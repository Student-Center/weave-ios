//
//  MyPageCategoryTypes.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/16/24.
//

import SwiftUI
import DesignSystem

enum MyPageCategoryTypes: CaseIterable {
    case contactPoint
    case myPrfile
    case universityVerification
    
    var headerTitle: String {
        switch self {
        case .contactPoint:
            return "연락수단"
        case .myPrfile:
            return "내 미팅 프로필"
        case .universityVerification:
            return "대학교 인증"
        }
    }
    
    var getSubViewTypes: [MyPageSubViewTypes] {
        switch self {
        case .contactPoint:
            return [
                .kakaoTalkId
            ]
        case .myPrfile:
            return [
                .mbti,
                .similarAnimal,
                .physicalHeight
            ]
        case .universityVerification:
            return [
                .emailVerification
            ]
        }
    }
    
    enum MyPageSubViewTypes: String {
        case kakaoTalkId
        case mbti
        case similarAnimal
        case physicalHeight
        case emailVerification
        
        var title: String {
            switch self {
            case .kakaoTalkId: return "카카오톡 ID"
            case .mbti: return "성격 유형"
            case .similarAnimal: return "닮은 동물"
            case .physicalHeight: return "키"
            case .emailVerification: return "학교 메일 인증"
            }
        }
        
        var icon: Image {
            switch self {
            case .kakaoTalkId:
                return DesignSystem.Icons.iconKakao
            case .mbti:
                return DesignSystem.Icons.puzzle
            case .similarAnimal:
                return DesignSystem.Icons.footprint
            case .physicalHeight:
                return DesignSystem.Icons.ruler
            case .emailVerification:
                return DesignSystem.Icons.eMail
            }
        }
        
        func actionTitle() -> String {
            return "30실 받기"
        }
    }
}
