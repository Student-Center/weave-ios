//
//  AppTabView.swift
//  weave-ios
//
//  Created by 강동영 on 2/21/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct AppTabView: View {
    var store: StoreOf<AppTabViewFeature>
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.$selection) {
                
                MatchedMeetingListView(
                    store: store.scope(
                        state: \.matchedMeeting,
                        action: { .matchedMeeting($0) }
                    )
                )
                .tag(AppScreen.chat)
                .tabItem {
                    Label {
                        Text("매칭")
                    } icon: {
                        DesignSystem.Icons.chat
                    }
                }
                
                
                RequestListView(
                    store: store.scope(
                        state: \.requestList,
                        action: { .requestList($0) }
                    )
                )
                .tag(AppScreen.request)
                .tabItem {
                    Label {
                        Text("요청")
                    } icon: {
                        DesignSystem.Icons.request
                    }
                }
                
                MeetingTeamListView(
                    store: store.scope(
                        state: \.meetingTeamList,
                        action: { .meetingTeamList($0) }
                    )
                )
                .tag(AppScreen.home)
                .tabItem {
                    Label {
                        Text("홈")
                    } icon: {
                        DesignSystem.Icons.home
                    }
                }
                
                MyTeamView(
                    store: store.scope(
                        state: \.myTeamList,
                        action: { .myTeamList($0) }
                    )
                )
                .tag(AppScreen.myTeam)
                .tabItem {
                    Label {
                        Text("내 팀")
                    } icon: {
                        DesignSystem.Icons.myTeam
                    }
                }
                
                MyPageView(
                    store: store.scope(
                        state: \.myPage,
                        action: { .myPage($0) }
                    )
                )
                .tag(AppScreen.myPage)
                .tabItem {
                    Label("마이", systemImage: "person.crop.circle")
                }
            }
            .tint(.white)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
