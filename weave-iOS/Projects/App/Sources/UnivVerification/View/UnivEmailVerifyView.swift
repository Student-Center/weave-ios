//
//  UnivEmailVerifyView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/21/24.
//

import SwiftUI
import DesignSystem

struct UnivEmailVerifyView: View {
    
    @State var verifyCode = String()
    @State var errorMessage: String?

    var body: some View {
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
                    verifyCode: $verifyCode,
                    errorMessage: $errorMessage
                )
                
                Spacer()
                
                HStack {
                    Button(action: {}, label: {
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
                    isEnabled: verifyCode.count == 6
                )
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

#Preview {
    UnivEmailVerifyView()
}
