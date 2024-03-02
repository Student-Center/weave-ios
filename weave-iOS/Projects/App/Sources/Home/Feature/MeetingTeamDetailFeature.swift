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
        @BindingState var teamList: MeetingTeamListModel?
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
        case fetchTeamUserInfo(response: MeetingTeamGetListDTO)
        
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTappedRequestMeetingButton:
                state.isShowNoTeamAlert.toggle()
                return .none
            case .requestTeamUserInfo:
                return .none
            case .fetchTeamUserInfo(let response):
                state.teamList = response.toDomain
                return .none
            default:
                return .none
            }
        }
    }
}
