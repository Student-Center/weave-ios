//
//  SettingFeautre.swift
//  weave-ios
//
//  Created by 강동영 on 3/11/24.
//

import SwiftUI
import ComposableArchitecture

struct SettingFeautre: Reducer {
    
    struct State: Equatable {
        @BindingState var isShowLogoutAlert: Bool = false
        @BindingState var isShowUnregisterAlert: Bool = false
    }
    
    enum Action: BindableAction {
        case inform
        case didTappedSubViews(view: SettingCategoryTypes.SettingSubViewTypes)
        case showLogoutAlert
        case showUnregisterAlert
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .inform:
                return .none
            case .didTappedSubViews(let type):
                switch type {
                case .termsAndConditions, .privacyPolicy:
                    if let url = type.url {
                        UIApplication.shared.open(url)
                    }
                case .logout:
                    state.isShowLogoutAlert = true
                case .unregister:
                    state.isShowUnregisterAlert = true
                }
                return .none
            case .showLogoutAlert:
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}

//MARK: - Destination
//extension SettingFeautre {
//    struct Destination: Reducer {
//        enum State: Equatable {
//            case
//        }
//        
//        enum Action {
//            
//        }
//        
//        var body: some ReducerOf<Self> {
//            Scope(state: /State, action: <#T##CaseKeyPath<_, ChildAction>#>, child: <#T##() -> _#>)
//        }
//    }
//    
//}
