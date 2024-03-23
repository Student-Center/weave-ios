//
//  MatchedMeetingListView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/21/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import CoreKit

struct MatchedMeetingListView: View {
    let store: StoreOf<MatchedMeetingListFeature>
    let column = GridItem(.fixed(UIScreen.main.bounds.size.width))
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    if let teamList = viewStore.teamList {
                        LazyVGrid(columns: [column], spacing: 16, content: {
                            ForEach(teamList.items, id: \.id) { team in
                                MeetingListItemView(teamModel: team.otherTeam)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        viewStore.send(.didTappedTeamView(team: team))
                                    }
                            }
                        })
                        .padding(.top, 20)
                    } else {
                        getEmptyView {
                            // ToDo
                        }
                    }
                }
                .onLoad {
                    viewStore.send(.requestMeetingTeamList)
                }
                .navigationDestination(
                    store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                    state: /MatchedMeetingListFeature.Destination.State.matchingProfile,
                    action: MatchedMeetingListFeature.Destination.Action.matchingProfile
                ) { store in
                    MeetingMatchProfileView(store: store)
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("매칭")
                            .font(.pretendard(._600, size: 20))
                    }
                })
            }
        }
    }
    
    @ViewBuilder
    func getEmptyView(handler: @escaping () -> Void) -> some View {
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
                handler()
            }
            .padding(.horizontal, 80)
        }
    }
}

