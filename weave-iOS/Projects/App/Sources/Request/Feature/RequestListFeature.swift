//
//  RequestListFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/15/24.
//

import Foundation
import ComposableArchitecture
import Services

struct RequestListFeature: Reducer {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        
        @BindingState var receivedDataSources: [RequestMeetingItemModel] = []
        @BindingState var sentDataSources: [RequestMeetingItemModel] = []
    }
    
    enum Action: BindableAction {
        //MARK: UserAction
        case didTappedMeetingView(index: Int, type: RequestListType)
        case onAppear(type: RequestListType)
        case fetchData(dto: RequestMeetingListResponseDTO, type: RequestListType)
        case destination(PresentationAction<Destination.Action>)
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTappedMeetingView(let index, let type):
                switch type {
                case .receiving:
                    let meeting = state.receivedDataSources[index]
                    let myTeam = meeting.receivingTeam
                    let partnerTeam = meeting.requestingTeam
                    state.destination = .meetingMatch(
                        .init(
                            meetingId: meeting.id,
                            pendingEndAt: meeting.pendingEndAt,
                            meetingType: type,
                            myTeamModel: myTeam,
                            partnerTeamModel: partnerTeam
                        )
                    )
                case .requesting:
                    let meeting = state.sentDataSources[index]
                    let partnerTeam = meeting.receivingTeam
                    let myTeam = meeting.requestingTeam
                    state.destination = .meetingMatch(
                        .init(
                            meetingId: meeting.id,
                            pendingEndAt: meeting.pendingEndAt,
                            meetingType: type,
                            myTeamModel: myTeam,
                            partnerTeamModel: partnerTeam
                        )
                    )
                }
                return .none
                
            case .destination(.dismiss):
                state.destination = nil
                return .none

            case .binding(_):
                return .none
                
            case .onAppear(let type):
                return .run { send in
                    let response = try await requestMeetingList(type: type)
                    await send.callAsFunction(.fetchData(dto: response, type: type))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchData(let response, let type):
                switch type {
                case .receiving:
                    let data = response.toDomain.items
                    state.receivedDataSources = data
                case .requesting:
                    let data = response.toDomain.items
                    state.sentDataSources = data
                }
                return .none
                
            default: return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
    
    func requestMeetingList(type: RequestListType) async throws -> RequestMeetingListResponseDTO {
        let requestDTO = RequestMeetingListRequestDTO(teamType: type)
        let endPoint = APIEndpoints.getRequestMeetingTeamList(request: requestDTO)
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
}

//MARK: - Destination
extension RequestListFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case meetingMatch(MeetingMatchFeature.State)
        }
        enum Action {
            case meetingMatch(MeetingMatchFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.meetingMatch, action: /Action.meetingMatch) {
                MeetingMatchFeature()
            }
        }
    }
}

