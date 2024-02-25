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
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: SecretKey.kakaoNativeKey)
    }
    
    var body: some Scene {
        WindowGroup {
            MyAnimalSelectionView(
                store: Store(initialState: MyAnimalSelectionFeature.State(), reducer: {
                    MyAnimalSelectionFeature()
                })
            )
        }
    }
}
