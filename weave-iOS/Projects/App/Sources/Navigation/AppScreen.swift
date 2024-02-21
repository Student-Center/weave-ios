//
//  AppScreen.swift
//  weave-ios
//
//  Created by 강동영 on 2/21/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case chat
    case request
    case home
    case myTeam
    case myPage
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .chat:
            Label {
                Text("채팅")
            } icon: {
                DesignSystem.Icons.chat
            }
        case .request:
            Label {
                Text("요청")
            } icon: {
                DesignSystem.Icons.request
            }
        case .home:
            Label {
                Text("홈")
            } icon: {
                DesignSystem.Icons.home
            }
        case .myTeam:
            Label {
                Text("내 팀")
            } icon: {
                DesignSystem.Icons.myTeam
            }
        case .myPage:
            Label("마이", systemImage: "person.crop.circle")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .chat:
            ChatView()
        case .home:
            HomeView()
        case .request:
            RequestView()
        case .myTeam:
            MyTeamView()
        case .myPage:
            MyPageView(store: Store(initialState: MyPageFeature.State(), reducer: {
                MyPageFeature()
            }))
        }
    }
}
