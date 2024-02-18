//
//  LoginView.swift
//  weave-ios
//
//  Created by 강동영 on 2/18/24.
//

import SwiftUI
import DesignSystem
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            DesignSystem.Icons.appLogo
            
            Spacer()
            Button(action: {
                isAvailableOpenKakao()
            }, label: {
                HStack {
                    DesignSystem.Icons.kakaoLogo
                    Text("카카오 로그인")
                        .foregroundColor(.black)
                }
                
            })
            .padding(20)
            .frame(width: 300, height: 44, alignment: .center)
            .background(Color(red: 1, green: 0.9, blue: 0))
            .cornerRadius(6)
            
            Spacer()
                .frame(height: 16)
            
            Button(action: {
                
            }, label: {
                HStack {
                    DesignSystem.Icons.appleLogo
                    Text("Apple로 로그인")
                        .foregroundColor(.black)
                }
                
            })
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(width: 300, height: 44, alignment: .center)
            .background(.white)
            .cornerRadius(6)
            Spacer()
                .frame(height: 58)
        }
    }
    
    private func isAvailableOpenKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
                    if let idToken = oauthToken?.idToken {
                        print("oauthToken: \(idToken)")
                    }
                    
                    _ = oauthToken
                }
            }
        }
    }
    
    private func requestSNSLogin() {
        
    }
}
