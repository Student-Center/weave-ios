//
//  AppTabView.swift
//  weave-ios
//
//  Created by 강동영 on 2/21/24.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
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

#Preview {
    AppTabView(selection: .constant(.chat))
}
