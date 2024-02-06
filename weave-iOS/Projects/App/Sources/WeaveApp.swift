//
//  WeaveApp.swift
//  Weave
//
//  Created by 강동영 on 11/28/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct WeaveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        KakaoSDK.initSDK(appKey: SecretKey.kakaoNativeKey)
    }
}
