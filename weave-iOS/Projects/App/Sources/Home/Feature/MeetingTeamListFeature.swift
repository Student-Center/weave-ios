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
        var filterModel = MeetingTeamFilterModel()
        
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
                return .run { [filter = state.filterModel] send in
                    let response = try await requestMeetingTeamList(filter: filter)
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
                state.destination = .filter(.init(filterModel: state.filterModel))
                return .none
                
            // Filter 선택 완료 이후
            case .destination(.presented(.filter(.dismissSaveFilter))):
                if case let .filter(filter) = state.destination {
                    print("FilterModel: \(filter)")
                    state.filterModel = filter.filterModel
                }
                state.destination = nil
                return .run { send in
                    await send.callAsFunction(.requestMeetingTeamList)
                }
                
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
    
    func requestMeetingTeamList(filter: MeetingTeamFilterModel) async throws -> MeetingTeamGetListDTO {
        let dto = MeetingTeamGetListRequestDTO(
            memberCount: filter.memberCount,
            youngestMemberBirthYear: filter.youngestMemberBirthYear,
            oldestMemberBirthYear: filter.oldestMemberBirthYear,
            preferredLocations: filter.preferredLocations
        )
        let endPoint = APIEndpoints.getMeetingTeamList(requestDTO: dto)
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
