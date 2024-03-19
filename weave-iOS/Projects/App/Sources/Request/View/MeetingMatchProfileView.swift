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
                        let profileViewConfig = UserProfileBoxConfig(
                            mbti: .ENTJ,
                            animal: .cat,
                            height: 184,
                            univName: "위브대학교",
                            majorName: "위브어때학과",
                            birthYear: 2005,
                            isUnivVerified: true
                        )
                        UserProfileBoxView(config: profileViewConfig)
                    }
                    .padding(.vertical, 20)
                }
                WeaveButton(title: "매칭 페이지로 이동", size: .large)
                    .padding(.horizontal, 16)
            }
            .navigationBarBackButtonHidden()
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MeetingMatchProfileView(store: Store(initialState: MeetingMatchProfileFeature.State(), reducer: {
        MeetingMatchProfileFeature()
    }))
}
