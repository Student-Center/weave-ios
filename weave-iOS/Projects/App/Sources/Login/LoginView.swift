//
//  LoginView.swift
//  weave-ios
//
//  Created by 강동영 on 2/18/24.
//

import SwiftUI
import DesignSystem
import Services

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            
            DesignSystem.Icons.appLogo
            Spacer()
            
            KakaoLoginButton(onComplte: { idToken in
                Task {
                    await requestSNSLogin(idToken: idToken, with: .kakao)
                }
            })
            Spacer()
                .frame(height: 16)
            
//            AppleLoginButton()
            
            Spacer()
                .frame(height: 58)
        }
    }
    
    private func requestSNSLogin(idToken: String, with type: SNSLoginType) async {
        let endPoint = APIEndpoints.requestSNSLogin(idToken: idToken, with: type)
        guard let provider = try? await APIProvider().request(with: endPoint) else { return }
        UDManager.accessToken = provider.accessToken
        UDManager.refreshToken = provider.refreshToken
    }
}
