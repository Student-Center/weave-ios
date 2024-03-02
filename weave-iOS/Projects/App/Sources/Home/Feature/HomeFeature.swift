//
//  HomeFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/28/24.
//

import Foundation
import Services
import ComposableArchitecture

struct HomeFeature: Reducer {
    struct State: Equatable {
        @BindingState var teamList: MeetingTeamListModel?
    }
    
    enum Action: BindableAction {
        case requestMeetingTeamList
        case fetchMeetingTeamList(response: MeetingTeamGetListDTO)
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .requestMeetingTeamList:
                return .run { send in
                    let response = try await requestMeetingTeamList()
                    await send.callAsFunction(.fetchMeetingTeamList(response: response))
                } catch: { error, send in
                    print(error)
                }
            case .fetchMeetingTeamList(let response):
                state.teamList = response.toDomain
                return .none
            default:
                return .none
            }
        }
    }
    
    func requestMeetingTeamList() async throws -> MeetingTeamGetListDTO {
        let endPoint = APIEndpoints.getMeetingTeamList()
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
}

enum TempError: Error {
    case tempError
}
