//
//  AppTabViewFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import ComposableArchitecture

struct AppTabViewFeature: Reducer {
    @Binding var rootview: RootViewType
    
    struct State: Equatable {
        @BindingState var selection: AppScreen = .home
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                
                
            case .binding:
                return .none
            }
        }
    }
}
