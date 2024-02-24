//
//  MyHeightEditFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/24/24.
//

import Foundation
import ComposableArchitecture
import Services

struct MyHeightEditFeature: Reducer {
    struct State: Equatable {
        @BindingState var heightText = String()
    }
    
    enum Action: BindableAction {
        case didTappedSaveButton
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTappedSaveButton:
                return .run { [height = state.heightText] send in
                    try await requestEditMyProfile(height: Int(height)!)
                } catch: { error, send in
                    print(error)
                }
                
            default:
                return .none
            }
        }
    }
    
    func requestEditMyProfile(height: Int) async throws {
        let endPoint = APIEndpoints.editMyHeight(body: .init(height: height))
        let provider = APIProvider()
        try await provider.requestWithNoResponse(with: endPoint)
    }
}
