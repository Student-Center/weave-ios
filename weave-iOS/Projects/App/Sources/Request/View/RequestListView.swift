//
//  RequestListView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/11/24.
//

import SwiftUI
import DesignSystem

struct RequestListView: View {
    @State var selection: Int = 0
    private let items: [String] = ["받은 요청", "보낸 요청"]
    
    var body: some View {
        VStack {
            SegmentedPicker(items: self.items, selection: self.$selection)
                .frame(width: 210)
            TabView(selection: $selection) {
                Text("받은 요청 뷰")
                    .tag(0)
                Text("보낸 요청 뷰")
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    RequestListView()
}
