//
//  HomeFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/28/24.
//

import Foundation
import Services
import ComposableArchitecture

struct MeetingTeamListFeature: Reducer {
    struct State: Equatable {
        @BindingState var teamList: MeetingTeamListModel?
        
        @PresentationState var destination: Destination.State?
    }
    
    enum Action: BindableAction {
        case requestMeetingTeamList
        case fetchMeetingTeamList(response: MeetingTeamGetListDTO)
        
        //MARK: UserAction
        case didTappedTeamView(id: String)
        case didTappedFilterIcon
        
        // destination
        case destination(PresentationAction<Destination.Action>)
        
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
                
            case .didTappedTeamView(let id):
                // 상세 뷰로 전환
                state.destination = .teamDetail(.init(teamId: id))
                return .none
                
            case .didTappedFilterIcon:
                state.destination = .filter(.init())
                return .none
                
//            case .destination(.presented(.filter(.dismissSaveFilter))):
//                guard case let .filter(filter) = self.destination
//                  else { return .none }
                
            case .destination(.dismiss):
                state.destination = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
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

//MARK: - Destination
extension MeetingTeamListFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case teamDetail(MeetingTeamDetailFeature.State)
            case filter(MeetingTeamListFilterFeature.State)
        }
        enum Action {
            case teamDetail(MeetingTeamDetailFeature.Action)
            case filter(MeetingTeamListFilterFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.teamDetail, action: /Action.teamDetail) {
                MeetingTeamDetailFeature()
            }
            Scope(state: /State.filter, action: /Action.filter) {
                MeetingTeamListFilterFeature()
            }
        }
    }
}
