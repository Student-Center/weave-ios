//
//  UnivEmailVerifyFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/21/24.
//

import Foundation
import Services
import ComposableArchitecture

struct UnivEmailVerifyFeature: Reducer {
    
    struct State: Equatable {
        let userEmail: String
        @BindingState var verifyCode = String()
        @BindingState var errorMessage: String?
    }
    
    enum Action: BindableAction {
        case didTappedVerifyButton
        case didTappedRetrySendButton
        case fetchErrorMessage
        case didVerifyCodeChanged(value: String)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTappedVerifyButton:
                return .run { [email = state.userEmail, code = state.verifyCode] send in
                    try await requestVerifyCode(email: email, code: code)
                } catch: { error, send in
                    await send.callAsFunction(.fetchErrorMessage)
                }
                
            case .didTappedRetrySendButton:
                return .run { [email = state.userEmail] send in
                    try await requestSendVerificationEmail(email: email)
                } catch: { error, send in
                    print(error)
                }
                
            case .didVerifyCodeChanged(_):
                state.errorMessage = nil
                return .none
                
            case .fetchErrorMessage:
                state.errorMessage = "인증번호를 다시 확인해 주세요"
                return .none
                
            default:
                return .none
            }
        }
    }
    
    func requestVerifyCode(email: String, code: String) async throws {
        let dto = EmailVerifyRequestDTO(
            universityEmail: email,
            verificationNumber: code
        )
        let endPoint = APIEndpoints.verifyCode(body: dto)
        let provider = APIProvider()
        let statusCode = try await provider.request(with: endPoint)
        if statusCode == 204 {
            return
        } else {
            throw VerifyEmailError.verifyError
        }
    }
    
    func requestSendVerificationEmail(email: String) async throws {
        let endPoint = APIEndpoints.sendVerifyEmail(body: .init(universityEmail: email))
        let provider = APIProvider()
        let statusCode = try await provider.request(with: endPoint)
        if statusCode == 204 {
            return
        } else {
            throw VerifyEmailError.retrySendEmailError
        }
    }
    
    enum VerifyEmailError: Error {
        case verifyError
        case retrySendEmailError
    }
}
