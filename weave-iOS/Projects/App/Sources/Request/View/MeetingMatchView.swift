//
//  MeetingMatchView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/17/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct MeetingMatchView: View {
    
    let store: StoreOf<MeetingMatchFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ScrollView {
                    VStack {
                        getTimeRemainView()
                        MeetingMatchTeamView(
                            title: "상대 팀",
                            teamInfo: viewStore.partnerTeamModel
                        )
                        MeetingMatchTeamView(
                            title: "내 팀",
                            teamInfo: viewStore.myTeamModel
                        )
                    }
                    .padding(.horizontal, 16)
                }
                
                WeaveButton(title: "요청", size: .large)
                    .padding(.horizontal, 16)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .navigationTitle("미팅 매치")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewStore.send(.didTappedBackButton)
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                    .foregroundStyle(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    func getTimeRemainView() -> some View {
        VStack {
            Text("미팅 패스까지 남은 시간")
            Text("05 : 24 : 26")
            Text("시간이 다 되면 미팅이 자동으로 패스돼요!")
        }
    }
}

fileprivate struct MeetingMatchTeamView: View {
    let title: String
    let teamInfo: RequestMeetingTeamInfoModel
    
    var attendancedMemberCount: Int {
        return teamInfo.memberInfos
            .filter { $0.isAttendance == true }
            .count
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.pretendard(._600, size: 16))
                    .padding(.vertical, 16)
                Spacer()
            }
            
            VStack(spacing: 20) {
                HStack {
                    RoundCornerBoxedTextView(
                        teamInfo.teamIntroduce,
                        tintColor: DesignSystem.Colors.lightGray
                    )
                    Spacer()
                    HStack(spacing: 5) {
                        Image(systemName: "checkmark.circle")
                        Text("\(attendancedMemberCount)명")
                            .font(.pretendard(._500, size: 12))
                    }
                    .foregroundStyle(DesignSystem.Colors.subGreen)
                }
                
                HStack(alignment: .top) {
                    Spacer()
                    ForEach(teamInfo.memberInfos, id: \.id) { member in
                        MemberIconView(
                            title: member.memberInfoValue,
                            subTitle: member.mbti ?? "",
                            isStroke: true,
                            overlay: {
                                if member.isAttendance == true {
                                    DesignSystem.Icons.greenCheck
                                }
                            }
                        )
                    }
                    Spacer()
                }
            }
            .weaveBoxStyle()
        }
    }
}

#Preview {
    AppTabView(store: .init(initialState: AppTabViewFeature.State(), reducer: {
        AppTabViewFeature(rootview: .constant(.mainView))
    }))
}
