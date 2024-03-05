//
//  MyTeamView.swift
//  weave-ios
//
//  Created by 강동영 on 2/21/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct MyTeamView: View {
    
    let store: StoreOf<MyTeamFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                getEmptyView() {
                    viewStore.send(.didTappedGenerateMyTeam)
                }
                .navigationDestination(
                    store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                    state: /MyTeamFeature.Destination.State.generateMyTeam,
                    action: MyTeamFeature.Destination.Action.generateMyTeam
                ) { store in
                    GenerateMyTeamView(store: store)
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("내 팀")
                            .font(.pretendard(._600, size: 20))
                    }
                })
            }
        }
    }
    
    @ViewBuilder
    func getEmptyView(handler: @escaping () -> Void) -> some View {
        VStack(spacing: 10) {
            Text("내 팀을 만들어 보세요!")
                .font(.pretendard(._600, size: 22))
            Text("내 팀이 있어야 미팅 요청을 할 수 있어요.")
                .font(.pretendard(._500, size: 14))
                .foregroundStyle(DesignSystem.Colors.gray600)
            Spacer()
                .frame(height: 20)
            WeaveButton(title: "내 팀 만들기", size: .large) {
                handler()
            }
            .padding(.horizontal, 80)
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.myTeam))
}
