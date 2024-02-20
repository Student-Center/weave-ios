//
//  UnivEmailVerifyView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/21/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct UnivEmailVerifyView: View {
    
    let store: StoreOf<UnivEmailVerifyFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    VStack(spacing: 12) {
                        Text(
                        """
                        받은 인증번호 6자리를
                        입력해 주세요
                        """
                        )
                        .multilineTextAlignment(.center)
                        .font(.pretendard(._500, size: 24))
                        
                        HStack(spacing: 2) {
                            Image(systemName: "stopwatch")
                            Text("05:00")
                        }
                        .font(.pretendard(._500, size: 16))
                        .foregroundStyle(DesignSystem.Colors.lightGray)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                    
                    VerifyCodeInputView(
                        verifyCode: viewStore.$verifyCode,
                        errorMessage: viewStore.$errorMessage
                    )
                    
                    if let errorMessage = viewStore.errorMessage {
                        Spacer()
                            .frame(height: 16)
                        
                        Text(errorMessage)
                            .font(.pretendard(._400, size: 12))
                            .foregroundStyle(DesignSystem.Colors.notificationRed)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            viewStore.send(.didTappedRetrySendButton)
                        }, label: {
                            Image(systemName: "goforward").rotationEffect(.degrees(90))
                            Text("인증번호 다시 받기")
                                .font(.pretendard(._400, size: 14))
                        })
                    }
                    .foregroundStyle(DesignSystem.Colors.defaultBlue)
                    .frame(height: 40)
                    
                    WeaveButton(
                        title: "학교 인증하기",
                        size: .large,
                        isEnabled: viewStore.verifyCode.count == 6
                    ) {
                        viewStore.send(.didTappedVerifyButton)
                    }
                    .padding(.horizontal, 16)
                }
                .navigationTitle("대학교 인증")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    UnivEmailVerifyView(
        store: .init(
            initialState: UnivEmailVerifyFeature.State(userEmail: ""),
            reducer: {
                UnivEmailVerifyFeature()
            })
    )
}
