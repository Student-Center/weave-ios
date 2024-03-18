//
//  SettingFeautre.swift
//  weave-ios
//
//  Created by 강동영 on 3/11/24.
//

import SwiftUI
import ComposableArchitecture
import Services

struct SettingFeautre: Reducer {
    
    struct State: Equatable {
        @BindingState var isShowLogoutAlert: Bool = false
        @BindingState var isShowUnregisterAlert: Bool = false
    }
    
    enum Action: BindableAction {
        case inform
        case didTappedSubViews(view: SettingCategoryTypes.SettingSubViewTypes)
        case showLogoutAlert(model: PathModel)
        case showUnregisterAlert(model: PathModel)
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
            case .showLogoutAlert(let pathModel):
                UDManager.accessToken = ""
                UDManager.refreshToken = ""
                pathModel.currentRoot = .loginView
                return .none
            case .showUnregisterAlert(let pathModel):
                pathModel.currentRoot = .loginView
                return .run { send in
                    // TODO: -
                    UDManager.accessToken = ""
                    UDManager.refreshToken = ""
                } catch: { error, send in
                    // TODO:
                }
            case .binding(_):
                return .none
            }
        }
    }
    
    func requestUnregist() async throws -> MeetingTeamDetailResponseDTO {
        let endPoint = APIEndpoints.getMeetingTeamDetail(teamId: "teamId")
        let provider = APIProvider()
        let response = try await provider.request(with: endPoint)
        return response
    }
}
