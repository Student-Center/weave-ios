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
                    .padding(.vertical, 16)
                    
                    VStack {
                        ForEach(viewStore.partnerTeamModel.memberInfos, id: \.id) { member in
                            let mbtiType = MBTIType(rawValue: member.mbti)
                            let animalType = member.animalType
                            let profileImage = viewStore.isProfileOpen ? member.avatar : mbtiType?.mbtiProfileImage
                            let kakaoId = viewStore.isProfileOpen ? member.kakaoId : nil
                            
                            let profileViewConfig = UserProfileBoxConfig(
                                id: member.id,
                                mbti: mbtiType,
                                animal: animalType,
                                height: member.height,
                                profileImage: profileImage,
                                univName: member.universityName,
                                majorName: "학과정보없음", // ToDo - 학과
                                birthYear: member.birthYear,
                                isUnivVerified: true,
                                kakaoId: kakaoId
                            )
                            UserProfileBoxView(config: profileViewConfig, needShowMenu: true, menuHandler: { id in
                                viewStore.send(.didTappedUserMenu(id: id))
                            })
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewStore.send(.didProfileTapped)
                            }
                            .confirmationDialog("타이틀", isPresented: viewStore.$isShowUserMenu) {
                              Button("신고", role: .destructive) {
                                  viewStore.send(.requestReportUser)
                              }
                              Button("취소", role: .cancel) {}
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                WeaveButton(title: "매칭 페이지로 이동", size: .large) {
                    viewStore.send(.didTappedGoToMatchingView)
                }
                .padding(.horizontal, 16)
            }
            .weaveAlert(
                isPresented: viewStore.$isShowCompleteReportAlert, 
                title: "신고가 정상적으로\n처리되었어요!",
                primaryButtonTitle: "확인"
            )
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
