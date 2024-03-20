//
//  MeetingMatchProfileView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/19/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct MeetingMatchProfileView: View {
    let store: StoreOf<MeetingMatchProfileFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ScrollView {
                    VStack(spacing: 13) {
                        Text("매칭 성공!")
                            .font(.pretendard(._700, size: 23))
                            .foregroundStyle(DesignSystem.Colors.defaultBlue)
                        
                        Text("카드를 클릭해 상대의 프로필과\n카카오톡 ID를 확인해 보세요!")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(DesignSystem.Colors.gray600)
                            .font(.pretendard(._400, size: 12))
                            .lineSpacing(4)
                    }
                    
                    VStack {
                        ForEach(viewStore.partnerTeamModel.memberInfos, id: \.id) { member in
                            let mbtiType = MBTIType(rawValue: member.mbti ?? "")
                            let profileViewConfig = UserProfileBoxConfig(
                                mbti: mbtiType,
                                animal: member.animalType,
                                height: nil,
                                univName: member.universityName,
                                majorName: "학과정보없음",
                                birthYear: member.birthYear,
                                isUnivVerified: true
                            )
                            UserProfileBoxView(config: profileViewConfig)
                        }
                    }
                    .padding(.vertical, 20)
                }
                WeaveButton(title: "매칭 페이지로 이동", size: .large)
                    .padding(.horizontal, 16)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewStore.send(.didTappedBackButton)
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(viewStore.partnerTeamModel.teamIntroduce)
                                .font(.pretendard(._600, size: 16))
                        }
                    })
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    MeetingMatchProfileView(store: Store(initialState: MeetingMatchProfileFeature.State(meetingId: "", partnerTeamModel: .init(id: "", teamIntroduce: "", memberCount: 2, gender: "", memberInfos: [])), reducer: {
        MeetingMatchProfileFeature()
    }))
}
