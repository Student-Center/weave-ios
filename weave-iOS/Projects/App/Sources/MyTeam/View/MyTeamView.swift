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
                VStack {
                    if viewStore.didDataFetched && viewStore.myTeamList.isEmpty {
                        getEmptyView() {
                            viewStore.send(.didTappedGenerateMyTeam)
                        }
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewStore.myTeamList, id: \.id) { team in
                                    MyTeamItemView(store: store, teamModel: team)
                                }
                            }
                            .padding(.vertical, 20)
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.requestMyTeamList)
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

fileprivate struct MyTeamItemView: View {
    let store: StoreOf<MyTeamFeature>
    let teamModel: MyTeamItemModel
    
    fileprivate var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    RoundCornerBoxedTextView(
                        teamModel.memberCount?.text ?? "",
                        tintColor: DesignSystem.Colors.lightGray
                    )
                    RoundCornerBoxedTextView(
                        teamModel.teamIntroduce,
                        tintColor: DesignSystem.Colors.lightGray
                    )
                    Spacer()
                    DesignSystem.Icons.menu
                }
                
                HStack {
                    Spacer()
                    ForEach(teamModel.memberInfos, id: \.id) { member in
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 48, height: 48)
                            .frame(maxWidth: .infinity)
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 19)
            .padding([.top, .leading, .trailing], 12)
            .background(DesignSystem.Colors.darkGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.myTeam))
}
