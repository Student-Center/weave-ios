//
//  WeaveApp.swift
//  Weave
//
//  Created by 강동영 on 11/28/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct WeaveApp: App {
    var body: some Scene {
        WindowGroup {
            SignUpView(
                store: Store(
                    initialState: SignUpFeature.State()) {
                        SignUpFeature()
                    }
            )
        }
    }
}
