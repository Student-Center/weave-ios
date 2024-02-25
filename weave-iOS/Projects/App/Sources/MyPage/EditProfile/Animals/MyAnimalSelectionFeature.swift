//
//  MyAnimalSelectionFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/25/24.
//

import Foundation
import ComposableArchitecture
import Services
import DesignSystem

struct MyAnimalSelectionFeature: Reducer {
    struct State: Equatable {
        var selectedAnimal: AnimalTypes?
    }
    
    enum Action: BindableAction {
        case didTappedSaveButton(animal: AnimalTypes)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTappedSaveButton(let animal):
                print(animal)
                return .none
                
            default:
                return .none
            }
        }
    }
}
