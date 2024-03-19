//
//  MeetingMatchProfileFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/19/24.
//

import Foundation
import ComposableArchitecture
import Services

struct MeetingMatchProfileFeature: Reducer {
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        @PresentationState var destination: Destination.State?

    }
    
    enum Action: BindableAction {
        //MARK: UserAction
        case didTappedBackButton

        case onAppear
        case destination(PresentationAction<Destination.Action>)
        
        // bind
        case binding(BindingAction<State>)
    }
    
    private enum CancelID {
        case timer
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
                
            case .binding(_):
                return .none
                
            case .onAppear:
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}

//MARK: - Destination
extension MeetingMatchProfileFeature {
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
