//
//  AppView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            switch coordinator.currentRoot {
            case .mainView:
                AppTabView(
                    store: Store(
                        initialState: AppTabViewFeature.State(),
                        reducer: {
                            AppTabViewFeature()
                        }
                    )
                )
                .environmentObject(coordinator)
            case .loginView:
                LoginView()
                    .environmentObject(coordinator)
            case .signUpView(let registToken):
                SignUpView(
                    store: Store(
                        initialState: SignUpFeature.State(
                            registerToken: registToken
                        )
                    ) {
                        SignUpFeature()
                    }
                )
                .environmentObject(coordinator)
            }
        }
    }
}




@MainActor final class AppCoordinator: ObservableObject {
    @Published var paths: [RootViewType] = []
    @Published private(set) var currentRoot: RootViewType
    
    static let shared: AppCoordinator = AppCoordinator()
    
    enum RootViewType: Hashable {
        case mainView
        case loginView
        case signUpView(registToken: String)
    }
    
    public func changeRoot(to viewType: RootViewType) {
        currentRoot = viewType
    }
    
    public func appendPath(_ path: RootViewType) {
        paths.append(path)
    }
    private init() {
        if UDManager.isLogin {
            currentRoot = .mainView
        } else {
            currentRoot = .loginView
        }
    }
}
