//
//  AppTabViewFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import Services
import ComposableArchitecture

struct AppTabViewFeature: Reducer {
    struct State: Equatable {
        @BindingState var selection: AppScreen = .home
        
        // Tap SubView States
        var matchedMeeting = MatchedMeetingListFeature.State()
        var requestList = RequestListFeature.State()
        var meetingTeamList = MeetingTeamListFeature.State()
        var myTeamList = MyTeamFeature.State()
        var myPage = MyPageFeature.State()
        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        
        case requestMyUserInfo
        case fetchMyUserInfo(userInfo: MyUserInfoResponseDTO)
        
        // Tap SubView Actions
        case matchedMeeting(MatchedMeetingListFeature.Action)
        case requestList(RequestListFeature.Action)
        case meetingTeamList(MeetingTeamListFeature.Action)
        case myTeamList(MyTeamFeature.Action)
        case myPage(MyPageFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send.callAsFunction(.requestMyUserInfo)
                }
                
            case .requestMyUserInfo:
                return .run { send in
                    let userInfo = try await requestMyUserInfo()
                    await send.callAsFunction(.fetchMyUserInfo(userInfo: userInfo))
                }
                
            case .fetchMyUserInfo(let userInfo):
                UserInfo.myInfo = userInfo.toDomain
                return .none
            
            case .binding:
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.matchedMeeting, action: /Action.matchedMeeting) {
            MatchedMeetingListFeature()
        }
        Scope(state: \State.requestList, action: /Action.requestList) {
            RequestListFeature()
        }
        Scope(state: \State.meetingTeamList, action: /Action.meetingTeamList) {
            MeetingTeamListFeature()
        }
        Scope(state: \State.myTeamList, action: /Action.myTeamList) {
            MyTeamFeature()
        }
        Scope(state: \State.myPage, action: /Action.myPage) {
            MyPageFeature()
        }

    }
    
    func requestMyUserInfo() async throws -> MyUserInfoResponseDTO {
        let endPoint = APIEndpoints.getMyUserInfo()
        let provider = APIProvider(session: URLSession.shared)
        let response = try await provider.request(with: endPoint)
        return response
    }
}
