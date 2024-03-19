//
//  TempChatView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/9/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct ChatView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("🙏")
                Text("조금만 기다려 주세요")
                    .font(.pretendard(._600, size: 22))
                Text("채팅 기능을 포함한 버전이\n곧 업데이트 될 예정이에요!")
                    .font(.pretendard(._500, size: 14))
                    .foregroundStyle(DesignSystem.Colors.gray600)
                Spacer()
                    .frame(height: 20)
                WeaveButton(title: "미팅 상대 둘러보기", size: .large) {
                    //                handler()
                }
                .padding(.horizontal, 80)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("채팅")
                        .font(.pretendard(._600, size: 20))
                }
            })
        }
    }
}

#Preview {
    AppTabView(
        store: Store(
            initialState: AppTabViewFeature.State(selection: .chat),
            reducer: {
                AppTabViewFeature()
            }
        )
    )
}
