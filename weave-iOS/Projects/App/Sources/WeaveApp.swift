//
//  WeaveApp.swift
//  Weave
//
//  Created by 강동영 on 11/28/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import ComposableArchitecture

@main
struct WeaveApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
//            ContentView()
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
        }
    }
    
    init() {
        KakaoSDK.initSDK(appKey: SecretKey.kakaoNativeKey)
    }
}
