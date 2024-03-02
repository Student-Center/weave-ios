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
    @Dependency(\.dismiss) var dismiss
    
    struct State: Equatable {
        var selectedAnimal: AnimalTypes?
        
        init(selectedAnimal: AnimalTypes? = nil) {
            self.selectedAnimal = selectedAnimal
        }
    }
    
    enum Action: BindableAction {
        case didTappedSaveButton(animal: AnimalTypes)
        case dismiss
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .didTappedSaveButton(let animal):
                return .run { send in
                    try await requestEditMyAnimal(animal: animal)
                    await send.callAsFunction(.dismiss)
                } catch: { error, send in
                    print(error)
                }
                
            case .dismiss:
                return .run { send in
                    await dismiss()
                }
                
            default:
                return .none
            }
        }
    }
    
    func requestEditMyAnimal(animal: AnimalTypes) async throws {
        let endPoint = APIEndpoints.editMyAnimal(body: .init(animalType: animal.requestValue))
        let provider = APIProvider()
        try await provider.requestWithNoResponse(with: endPoint)
    }
}
