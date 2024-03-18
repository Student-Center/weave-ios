//
//  SettingView.swift
//  weave-ios
//
//  Created by 강동영 on 3/11/24.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
    
    let store: StoreOf<MyPageFeature>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SettingView(store: Store(initialState: <#T##Reducer.State#>, reducer: <#T##() -> Reducer#>))
}
