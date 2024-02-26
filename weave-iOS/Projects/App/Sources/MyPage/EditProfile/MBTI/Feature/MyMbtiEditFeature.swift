//
//  MyMbtiEditFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/26/24.
//

import Foundation
import ComposableArchitecture
import Services
import DesignSystem

struct MyMbtiEditFeature: Reducer {
    struct State: Equatable {
        @BindingState var mbtiDataModel: MBTIDataModel
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
                return .run { [mbti = state.mbtiDataModel] send in
                    try await requestMyMBTIData(mbti: mbti)
                } catch: { error, send in
                    print(error)
                }
                
            default:
                return .none
            }
        }
    }
    
    func requestMyMBTIData(mbti: MBTIDataModel) async throws {
        let endPoint = APIEndpoints.editMyMbti(body: .init(mbti: mbti.requestValue))
        let provider = APIProvider()
        try await provider.requestWithNoResponse(with: endPoint)
    }
}
