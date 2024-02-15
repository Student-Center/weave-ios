//
//  MyPageCore.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/16/24.
//

import SwiftUI
import ComposableArchitecture

struct MyPageFeature: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action {
        case didTappedPreferenceButton
        case didTappedProfileView
        case didTappedProfileEditButton
        case didTappedSubViews(view: MyPageCategoryTypes.MyPageSubViewTypes)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTappedPreferenceButton:
                return .none
                
            case .didTappedProfileView:
                return .none
                
            case .didTappedProfileEditButton:
                return .none
                
            case .didTappedSubViews(let type):
                switch type {
                default: break
                }
                return .none
            }
        }
    }
}
