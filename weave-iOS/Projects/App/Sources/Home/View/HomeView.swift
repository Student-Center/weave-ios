//
//  HomeView.swift
//  weave-ios
//
//  Created by 강동영 on 2/21/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct HomeView: View {
    
    let store: StoreOf<HomeFeature>
    
    let column = GridItem(.fixed(UIScreen.main.bounds.size.width))
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                ScrollView {
                    if let teamList = viewStore.teamList {
                        LazyVGrid(columns: [column], spacing: 16, content: {
                            ForEach(teamList.items, id: \.self) { team in
                                MeetingListItemView(teamModel: team)
                            }
                        })
                        .padding(.top, 20)
                    }
                }
                .onAppear {
                    viewStore.send(.requestMeetingTeamList)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        DesignSystem.Icons.appLogo
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                
                            },
                            label: {
                                Image(systemName: "slider.horizontal.3")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        )
                    }
                }
            }
        }
    }
}

fileprivate struct MeetingListItemView: View {
    
    let teamModel: MeetingTeamModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                RoundCornerBoxedTextView("3 : 3")
                RoundCornerBoxedTextView(teamModel.teamIntroduce)
                Spacer()
                LocationIconView(region: "서울")
            }
            
            HStack {
                Spacer()
                ForEach(teamModel.memberInfos, id: \.self) { member in
                    userIconView(member)
                        .frame(maxWidth: .infinity)
                }
                Spacer()
            }
        }
        .padding(.all, 12)
        .background(DesignSystem.Colors.darkGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .padding(.horizontal, 16)
        .frame(height: 168)
    }
    
    @ViewBuilder
    func userIconView(_ user: MeetingMemberModel) -> some View {
        VStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 48, height: 48)
                .foregroundStyle(DesignSystem.Colors.lightGray)
            Text(user.userInfoString)
                .multilineTextAlignment(.center)
                .font(.pretendard(._600, size: 12))
                .padding(.vertical, 4)
        }
    }
    
    func getUserInfoString() {
        
    }
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State(), reducer: {
        HomeFeature()
    }))
}
