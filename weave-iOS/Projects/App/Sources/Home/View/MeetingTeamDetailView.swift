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
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack {
                            // 케이점수
                            getHeaderView()
                                .padding(.vertical, 24)
                            
                            // 유저
                            MeetingTeamUserProfileView()
                            MeetingTeamUserProfileView()
                            MeetingTeamUserProfileView()
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
                                
                            }
                        )
                        .weaveAlert(
                            isPresented: viewStore.$isShowRequestMeetingConfirmAlert,
                            title: "📤\n미팅 요청하기",
                            message: "{teamName}팀에게\n미팅을 요청할까요?",
                            primaryButtonTitle: "요청할래요",
                            secondaryButtonTitle: "아니요",
                            primaryAction: {
                                
                            }
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
                .onAppear {
                    viewStore.send(.requestTeamUserInfo)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("제목 최대 10글자인듯")
                                .font(.pretendard(._600, size: 16))
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        LocationIconView(region: "서울", tintColor: .white)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func getHeaderView() -> some View {
        VStack(spacing: 10) {
            Text("이런게 환상의 케미?")
                .font(.pretendard(._700, size: 20))
                .foregroundStyle(DesignSystem.Colors.defaultBlue)
            
            StarRatingView(rating: 4)
            
            Text("우리 팀과의 케미는 80점")
                .font(.pretendard(._500, size: 12))
                .foregroundStyle(DesignSystem.Colors.gray500)
        }
    }
}

fileprivate struct MeetingTeamUserProfileView: View {
    
    fileprivate var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                RoundCornerBoxedTextView("🧐 INTJ•지적인 친구")
                RoundCornerBoxedTextView(AnimalTypes.sloth.text)
                RoundCornerBoxedTextView("📏 176cm")
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    HStack(spacing: 3) {
                        Text("위브대학교")
                        DesignSystem.Icons.certified
                    }
                    Text("위브만세학과")
                    Text("05년생")
                }
                .font(.pretendard(._500, size: 16))
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(DesignSystem.Colors.lightGray)
            }
            .padding(.horizontal, 4)
        }
        .padding(.all, 12)
        .background(DesignSystem.Colors.darkGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .padding(.horizontal, 16)
        .frame(height: 180)
    }
}



#Preview {
    MeetingTeamDetailView(store: Store(initialState: MeetingTeamDetailFeature.State(), reducer: {
        MeetingTeamDetailFeature()
    }))
}
