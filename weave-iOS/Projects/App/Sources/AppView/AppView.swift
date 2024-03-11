//
//  AppView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @State var rootView: RootViewType
    @StateObject private var pathModel = PathModel()
    
    init() {
        if UDManager.isLogin {
            rootView = .mainView
        } else {
            rootView = .loginView
        }
    }

    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            switch rootView {
            case .mainView:
                AppTabView(
                    store: Store(
                        initialState: AppTabViewFeature.State(),
                        reducer: {
                            AppTabViewFeature(rootview: $rootView)
                        }
                    )
                )
            case .loginView:
                LoginView(rootview: $rootView)
            case .signUpView(let registToken):
                SignUpView(
                    store: Store(
                        initialState: SignUpFeature.State(
                            registerToken: registToken
                        )
                    ) {
                        SignUpFeature(rootView: $rootView)
                    }
                )
            }
        }
    }
}

enum RootViewType: Hashable {
    case mainView
    case loginView
    case signUpView(registToken: String)
}


class PathModel: ObservableObject {
    @Published var paths: [RootViewType]
    
    init(paths: [RootViewType] = []) {
        self.paths = paths
    }
}
