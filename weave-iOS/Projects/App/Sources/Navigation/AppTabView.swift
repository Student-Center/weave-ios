//
//  AppTabView.swift
//  weave-ios
//
//  Created by 강동영 on 2/21/24.
//

import SwiftUI
import ComposableArchitecture

struct AppTabView: View {
    var store: StoreOf<AppTabViewFeature>
        
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.$selection) {
                ForEach(AppScreen.allCases) { screen in
                    screen.destination
                        .tag(screen as AppScreen?)
                        .tabItem { screen.label }
                }
            }
            .tint(.white)
        }
    }
}
