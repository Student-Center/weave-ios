//
//  LoginView.swift
//  weave-ios
//
//  Created by 강동영 on 2/18/24.
//

import SwiftUI
import DesignSystem
import Services
import ComposableArchitecture

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
            
            AppleLoginButton(onComplte: { idToken in
                Task {
                    await requestSNSLogin(idToken: idToken, with: .apple)
                }
            })
            
            Spacer()
                .frame(height: 58)
        }
    }
    
    private func requestSNSLogin(idToken: String, with type: SNSLoginType) async {
        let endPoint = APIEndpoints.requestSNSLogin(idToken: idToken, with: type)
        guard let provider = try? await APIProvider().request(with: endPoint) else {
            // TODO: - SignUpView 연동
            landingToSignUp(idToken: idToken)
            return
        }
        
        UDManager.accessToken = provider.accessToken
        UDManager.refreshToken = provider.refreshToken
        
//        landingToHomeView()
    }
    
    private func landingToSignUp(idToken: String) {
        SignUpView(
            store: Store(
                initialState: SignUpFeature.State(registerToken: idToken)) {
                    SignUpFeature()
                }
        )
    }
    
//    private func landingToHomeView() {
//        HomeView()
//    }
}
