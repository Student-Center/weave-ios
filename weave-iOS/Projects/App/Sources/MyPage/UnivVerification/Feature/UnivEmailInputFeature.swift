//
//  UnivEmailInputFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/19/24.
//

import Foundation
import Services
import ComposableArchitecture

struct UnivEmailInputFeature: Reducer {
    
    let universityName: String
    
    struct State: Equatable {
        var universityInfo: UniversityInfoModel?
        @BindingState var emailPrefix = String()
        @BindingState var isShowEmailSendAlert = false
        @BindingState var isShowEmailSendErrorAlert = false
        @BindingState var pushToNextView = false
    }
    
    enum Action: BindableAction {
        case requestUniversityInfo
        case fetchUniversityInfo(dto: UniversityInfoResponseDTO)
        case requestSendVerifyEmail
        case showSendErrorAlert
        case didCompleteSendEmail
        case pushNextView
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .requestSendVerifyEmail:
                return .run { [emailPrefix = state.emailPrefix, univInfo = state.universityInfo] send in
                    try await requestSendVerificationEmail(
                        email: emailPrefix + "@" + (univInfo?.domainAddress ?? "")
                    )
                    await send.callAsFunction(.didCompleteSendEmail)
                } catch: { error, send in
                    print(error)
                    // 이메일 전송 에러처리
                    await send.callAsFunction(.showSendErrorAlert)
                }
                
            case .requestUniversityInfo:
                return .run { send in
                    let univInfo = try await requestUniversityInfo()
                    await send.callAsFunction(.fetchUniversityInfo(dto: univInfo))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchUniversityInfo(let dto):
                state.universityInfo = dto.toDomain
                return .none
                
            case .showSendErrorAlert:
                state.isShowEmailSendErrorAlert.toggle()
                return .none
                
            case .didCompleteSendEmail:
                state.isShowEmailSendAlert.toggle()
                return .none
                
            case .pushNextView:
                state.pushToNextView.toggle()
                return .none
                
            default:
                return .none
            }
        }
    }
    
    func requestUniversityInfo() async throws -> UniversityInfoResponseDTO {
        let endPoint = APIEndpoints.getSingleUniversityInfo(univName: universityName)
        let provider = APIProvider()
        let response: UniversityInfoResponseDTO = try await provider.request(with: endPoint)
        return response
    }
    
    // 이메일 보내기
    func requestSendVerificationEmail(email: String) async throws {
        print("👉 발송 이메일: \(email)")
        let endPoint = APIEndpoints.sendVerifyEmail(body: .init(universityEmail: email))
        let provider = APIProvider()
        try await provider.requestWithNoResponse(with: endPoint)
    }
    
    enum SendEmailError: Error {
        case statusCodeError
    }
}
