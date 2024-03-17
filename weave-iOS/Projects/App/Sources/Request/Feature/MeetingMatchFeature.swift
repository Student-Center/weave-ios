//
//  MeetingMatchFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/17/24.
//

import Foundation
import ComposableArchitecture
import Services

struct MeetingMatchFeature: Reducer {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        let meetingId: String
        let meetingType: RequestListType
        @BindingState var myTeamModel: RequestMeetingTeamInfoModel
        @BindingState var partnerTeamModel: RequestMeetingTeamInfoModel
    }
    
    enum Action: BindableAction {
        //MARK: UserAction
        case didTappedBackButton
        
        case onAppear
        case fetchData(dto: MeetingAttendanceResponseDTO)
        case destination(PresentationAction<Destination.Action>)
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .didTappedBackButton:
                return .run { send in
                    await dismiss()
                }
                
            case .destination(.dismiss):
                state.destination = nil
                return .none
                
            case .destination(.presented(.generateMyTeam(.didSuccessedGenerateTeam))):
                state.destination = nil
                return .none
                
            case .binding(_):
                return .none
                
            case .onAppear:
                return .run { [id = state.meetingId] send in
                    let response = try await requestAttendanceStatus(meetingId: id)
                    await send.callAsFunction(.fetchData(dto: response))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchData(let response):
                response.meetingAttendances.forEach { attendanceStatus in
                    if let index = state.myTeamModel.memberInfos.firstIndex(where: { $0.id == attendanceStatus.memberId }) {
                        state.myTeamModel.memberInfos[index].isAttendance = true
                    }
                }
                return .none
                
            default: return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
    
    func requestAttendanceStatus(meetingId: String) async throws -> MeetingAttendanceResponseDTO {
        let endPoint = APIEndpoints.getAttendanceStatus(teamId: meetingId)
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
}

//MARK: - Destination
extension MeetingMatchFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case generateMyTeam(GenerateMyTeamFeature.State)
        }
        enum Action {
            case generateMyTeam(GenerateMyTeamFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.generateMyTeam, action: /Action.generateMyTeam) {
                GenerateMyTeamFeature()
            }
        }
    }
}

