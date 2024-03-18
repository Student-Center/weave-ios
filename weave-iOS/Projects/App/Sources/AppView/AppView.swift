//
//  AppView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            switch pathModel.currentRoot {
            case .mainView:
                AppTabView(
                    store: Store(
                        initialState: AppTabViewFeature.State(),
                        reducer: {
                            AppTabViewFeature()
                        }
                    )
                )
                .environmentObject(pathModel)
            case .loginView:
                LoginView(rootview: $pathModel.currentRoot)
            case .signUpView(let registToken):
                SignUpView(
                    store: Store(
                        initialState: SignUpFeature.State(
                            registerToken: registToken
                        )
                    ) {
                        SignUpFeature(rootView: $pathModel.currentRoot)
                    }
                )
            }
        }
    }
}




final class PathModel: ObservableObject {
    @Published var paths: [RootViewType] = []
    @Published var currentRoot: RootViewType
    
    static let shared: PathModel = PathModel()
    
    enum RootViewType: Hashable {
        case mainView
        case loginView
        case signUpView(registToken: String)
    }
    
    private init() {
        if !UDManager.isLogin {
            currentRoot = .mainView
        } else {
            currentRoot = .loginView
        }
    }
}
