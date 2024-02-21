//
//  ContentView.swift
//  weave-ios
//
//  Created by 강동영 on 11/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: AppScreen? = .home
    var body: some View {
        if UDManager.isLogin {
            AppTabView(selection: $selection)
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
