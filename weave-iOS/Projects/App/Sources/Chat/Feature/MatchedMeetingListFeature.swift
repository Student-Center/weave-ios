//
//  MatchedMeetingListFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/21/24.
//

import Foundation
import Services
import ComposableArchitecture

struct MatchedMeetingListFeature: Reducer {
    struct State: Equatable {
        @BindingState var teamList: MatchedMeetingTeamList?
        @PresentationState var destination: Destination.State?
    }
    
    enum Action: BindableAction {
        case requestMeetingTeamList
        case fetchMeetingTeamList(response: MatchedMeetingTeamListResponseDTO)
        
        //MARK: UserAction
        case onAppear
        case didTappedTeamView(team: MatchedMeetingTeamInfo)
        
        // destination
        case destination(PresentationAction<Destination.Action>)
        
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send.callAsFunction(.requestMeetingTeamList)
                }
                
            case .requestMeetingTeamList:
                return .run { send in
                    let response = try await requestMatchedTeamList()
                    await send.callAsFunction(.fetchMeetingTeamList(response: response))
                } catch: { error, send in
                    print(error)
                }
            case .fetchMeetingTeamList(let response):
                state.teamList = response.toDomain
                return .none
                
            case .didTappedTeamView(let team):
                // 상세 뷰로 전환
                state.destination = .matchingProfile(
                    .init(
                        meetingId: team.id,
                        partnerTeamModel: team.otherTeam
                    )
                )
                return .none
                
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
    func requestMatchedTeamList() async throws -> MatchedMeetingTeamListResponseDTO {
        let endPoint = APIEndpoints.getMatchedMeetingTeam()
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
}

//MARK: - Destination
extension MatchedMeetingListFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case matchingProfile(MeetingMatchProfileFeature.State)
        }
        enum Action {
            case matchingProfile(MeetingMatchProfileFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.matchingProfile, action: /Action.matchingProfile) {
                MeetingMatchProfileFeature()
            }
        }
    }
}
