//
//  WeaveApp.swift
//  Weave
//
//  Created by 강동영 on 11/28/23.
//

import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct WeaveApp: App {
    @StateObject private var pathModel: PathModel = PathModel.shared
    
    init() {
        UDManager.accessToken = SecretKey.token
        UDManager.refreshToken = SecretKey.token
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: SecretKey.kakaoNativeKey)
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(pathModel)
        }
    }
}
