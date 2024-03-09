//
//  MyTeamFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/6/24.
//

import Foundation
import Services
import ComposableArchitecture

struct MyTeamFeature: Reducer {
    struct State: Equatable {
        @BindingState var myTeamList: [MyTeamItemModel]
        @BindingState var isShowActivityView = false
        
        @PresentationState var destination: Destination.State?
        
        var didDataFetched = false
        var teamInviteLink: String?
        
        init(myTeamList: [MyTeamItemModel] = []) {
            self.myTeamList = myTeamList
        }
    }
    
    enum Action: BindableAction {
        //MARK: UserAction
        case didTappedGenerateMyTeam
        case didTappedModifyMyTeam(team: MyTeamItemModel)
        case didTappedInviteButton(team: MyTeamItemModel)
        
        case requestMyTeamList
        case fetchMyTeamList(dto: MyTeamListResponseDTO)
        case fetchInviteLink(dto: MyTeamInviteResponseDTO)
        case requestDeleteTeam(teamId: String)
        
        case destination(PresentationAction<Destination.Action>)
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .didTappedGenerateMyTeam:
                state.destination = .generateMyTeam(.init())
                return .none
                
            case .didTappedModifyMyTeam(let team):
                let generateMyTeamState = GenerateMyTeamFeature.State(
                    myTeamModelFromEdit: team
                )
                state.destination = .generateMyTeam(generateMyTeamState)
                return .none
                
            case .didTappedInviteButton(let team):
                state.isShowActivityView.toggle()
                return .run { send in
                    let response = try await requestInviteLink(teamId: team.id)
                    await send.callAsFunction(.fetchInviteLink(dto: response))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchInviteLink(let dto):
                state.teamInviteLink = dto.meetingTeamInvitationLink
                state.isShowActivityView.toggle()
                return .none
                
            case .destination(.dismiss):
                state.destination = nil
                return .none
                
                
            case .requestMyTeamList:
                return .run { send in
                    let response = try await requestMyUserInfo()
                    await send.callAsFunction(.fetchMyTeamList(dto: response))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchMyTeamList(let dto):
                state.didDataFetched = true
                state.myTeamList = dto.toDomain
                return .none
                
            case .requestDeleteTeam(let teamId):
                print(teamId)
                return .run { send in
                    try await requestDeleteTeamById(teamId: teamId)
                    await send.callAsFunction(.requestMyTeamList)
                } catch: { error, send in
                    print(error)
                }
                
            case .destination(.presented(.generateMyTeam(.didSuccessedGenerateTeam))):
                state.destination = nil
                state.myTeamList = []
                return .run { send in
                    await send.callAsFunction(.requestMyTeamList)
                }
                
            case .binding(_):
                return .none
                
            default: return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
    
    func requestInviteLink(teamId: String) async throws -> MyTeamInviteResponseDTO {
        let endPoint = APIEndpoints.createInviteLink(teamId: teamId)
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
    
    func requestMyUserInfo() async throws -> MyTeamListResponseDTO {
        let endPoint = APIEndpoints.getMyTeamList()
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
    
    func requestDeleteTeamById(teamId: String) async throws {
        let endPoint = APIEndpoints.deleteMyTeam(teamId: teamId)
        let provider = APIProvider()
        try await provider.requestWithNoResponse(with: endPoint)
    }
}

//MARK: - Destination
extension MyTeamFeature {
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

