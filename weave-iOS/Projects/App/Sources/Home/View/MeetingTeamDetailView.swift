//
//  MeetingTeamDetailView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/1/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct MeetingTeamDetailView: View {
    
    let store: StoreOf<MeetingTeamDetailFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                if let teamModel = viewStore.teamModel {
                    ScrollView {
                        VStack {
                            // 케이점수
                            getHeaderView(teamModel)
                                .padding(.vertical, 24)
                            
                            // 유저
                            ForEach(teamModel.members, id: \.userId) { member in
                                let profileConfig = UserProfileBoxConfig(
                                    mbti: member.mbti,
                                    animal: member.animalType,
                                    height: member.height,
                                    univName: member.universityName,
                                    majorName: member.majorName,
                                    birthYear: member.birthYear,
                                    isUnivVerified: member.isUnivVerified
                                )
                                UserProfileBoxView(config: profileConfig)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    HStack(spacing: 9) {
                        WeaveButton(
                            title: "공유",
                            style: .outline,
                            size: .large,
                            textColor: DesignSystem.Colors.gray500,
                            backgroundColor: DesignSystem.Colors.gray500
                        )
                        .frame(width: (UIScreen.main.bounds.size.width - 32) * 0.3)
                        
                        WeaveButton(
                            title: "미팅 요청•0실",
                            size: .large,
                            textColor: .black,
                            isWeaveGraientBackground: true
                        ) {
                            viewStore.send(.didTappedRequestMeetingButton)
                        }
                        .weaveAlert(
                            isPresented: viewStore.$isShowNoTeamAlert,
                            title: "아직 내 팀이 없어요!",
                            message: """
                                    공개된 내 팀이 있어야
                                    미팅을 요청할 수 있어요.
                                    지금 바로 팀을 만들러 가볼까요?
                                    """,
                            primaryButtonTitle: "네, 좋아요",
                            secondaryButtonTitle: "아니요",
                            primaryAction: {
                                viewStore.send(.makeTeamAction)
                            }
                        )
                        .weaveAlert(
                            isPresented: viewStore.$isShowNoTeamAlert,
                            title: "대학교 인증이 필요해요",
                            message: """
                                    학교 메일을 인증한 회원만
                                    미팅 요청이 가능해요.
                                    바로 인증하러 가볼까요?
                                    """,
                            primaryButtonTitle: "네, 좋아요",
                            secondaryButtonTitle: "아니요",
                            primaryAction: {
                                viewStore.send(.univVerifyAction)
                            }
                        )
                        .weaveAlert(
                            isPresented: viewStore.$isShowRequestMeetingConfirmAlert,
                            title: "📤\n미팅 요청하기",
                            message: "\(teamModel.teamIntroduce) 팀에게\n미팅을 요청할까요?",
                            primaryButtonTitle: "요청할래요",
                            secondaryButtonTitle: "아니요",
                            primaryAction: {
                                viewStore.send(.requestMeeting)
                            }
                        )
                        .weaveAlert(
                            isPresented: viewStore.$isShowRequestSuccessAlert,
                            title: "요청 성공",
                            message: "\(teamModel.teamIntroduce) 팀에게\n미팅 요청을 성공했어요.",
                            primaryButtonTitle: "확인",
                            primaryAction: {
                                viewStore.send(.requestMeeting)
                            }
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
            .onAppear {
                viewStore.send(.requestTeamUserInfo)
            }
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewStore.send(.dismiss)
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("\(viewStore.teamModel?.teamIntroduce ?? "")")
                                .font(.pretendard(._600, size: 16))
                        }
                    })
                    .foregroundStyle(.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    LocationIconView(region: "서울", tintColor: .white)
                }
            }
        }
    }
    
    @ViewBuilder
    func getHeaderView(_ teamModel: MeetingTeamDetailModel) -> some View {
        VStack(spacing: 10) {
            if let affinityScore = teamModel.affinityScore {
                Text("이런게 환상의 케미?")
                    .font(.pretendard(._700, size: 20))
                    .foregroundStyle(DesignSystem.Colors.defaultBlue)
                
                StarRatingView(rating: Double(teamModel.affinityScore ?? 0))
                
                Text("우리 팀과의 케미는 \(20 * affinityScore)점")
                    .font(.pretendard(._500, size: 12))
                    .foregroundStyle(DesignSystem.Colors.gray500)
            } else {
                Text("케미 정보가 없습니다")
                    .font(.pretendard(._700, size: 20))
            }
        }
    }
}

#Preview {
    MeetingTeamDetailView(store: Store(initialState: MeetingTeamDetailFeature.State(teamId: ""), reducer: {
        MeetingTeamDetailFeature()
    }))
}
