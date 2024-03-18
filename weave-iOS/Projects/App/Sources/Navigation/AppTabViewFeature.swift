//
//  AppTabViewFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import Services
import ComposableArchitecture

struct AppTabViewFeature: Reducer {
    @Binding var rootview: RootViewType
    
    struct State: Equatable {
        @BindingState var selection: AppScreen = .home
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        
        case requestMyUserInfo
        case fetchMyUserInfo(userInfo: MyUserInfoResponseDTO)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send.callAsFunction(.requestMyUserInfo)
                }
                
            case .requestMyUserInfo:
                return .run { send in
                    let userInfo = try await requestMyUserInfo()
                    await send.callAsFunction(.fetchMyUserInfo(userInfo: userInfo))
                }
                
            case .fetchMyUserInfo(let userInfo):
                UserInfo.myInfo = userInfo.toDomain
                return .none
            
            case .binding:
                return .none
            }
        }
    }
    
    func requestMyUserInfo() async throws -> MyUserInfoResponseDTO {
        let endPoint = APIEndpoints.getMyUserInfo()
        let provider = APIProvider(session: URLSession.shared)
        let response = try await provider.request(with: endPoint)
        return response
    }
}
