//
//  MeetingTeamDetailFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/2/24.
//

import Foundation
import Services
import ComposableArchitecture

struct MeetingTeamDetailFeature: Reducer {
    struct State: Equatable {
        let teamId: String
        
        @BindingState var teamModel: MeetingTeamDetailModel?
        @BindingState var isShowRequestMeetingConfirmAlert = false
        @BindingState var isShowNeedUnivVerifyAlert = false
        @BindingState var isShowNoTeamAlert = false
    }
    
    enum Action: BindableAction {
        //MARK: UserAction
        case didTappedBackButton
        case didTappedShareButton
        case didTappedRequestMeetingButton
        
        //MARK: Alert Effect
        case makeTeamAction
        case univVerifyAction
        case requestMeeting
        
        case requestTeamUserInfo
        case fetchTeamUserInfo(response: MeetingTeamDetailResponseDTO)
        
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTappedRequestMeetingButton:
                state.isShowRequestMeetingConfirmAlert.toggle()
                return .none
            case .requestTeamUserInfo:
                return .run { [teamId = state.teamId] send in
                    let response = try await requestDetailTeamInfo(teamId: teamId)
                    await send.callAsFunction(.fetchTeamUserInfo(response: response))
                } catch: { error, send in
                    print(error)
                }
            case .fetchTeamUserInfo(let response):
                state.teamModel = response.toDomain
                return .none
                
            // 미팅 요청
            case .requestMeeting:
                return .run { [teamId = state.teamId] send in
                    try await requestMeeting(targetTeamId: teamId)
                    print("성공")
                } catch: { error, send in
                    print(error)
                }
            default:
                return .none
            }
        }
    }
    
    func requestDetailTeamInfo(teamId: String) async throws -> MeetingTeamDetailResponseDTO {
        let endPoint = APIEndpoints.getMeetingTeamDetail(teamId: teamId)
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
    
    func requestMeeting(targetTeamId: String) async throws {
        let requestDTO = RequestMeetingRequestDTO(receivingMeetingTeamId: targetTeamId)
        let endPoint = APIEndpoints.getRequestMeeting(requestDTO: requestDTO)
        let provider = APIProvider()
        try await provider.requestWithNoResponse(with: endPoint)
    }
}
