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
    
    func getSubViewModels() -> [MyPageSubViewItemModel] {
        switch self {
        case .contactPoint:
            return [
                MyPageSubViewItemModel(
                    category: self,
                    icon: DesignSystem.Icons.iconKakao,
                    title: "카카오톡 ID",
                    actionTitle: "30실 받기"
                )
            ]
        case .myPrfile:
            return [
                MyPageSubViewItemModel(
                    category: self,
                    icon: DesignSystem.Icons.puzzle,
                    title: "성격 유형",
                    actionTitle: "ENTJ"
                ),
                MyPageSubViewItemModel(
                    category: self,
                    icon: DesignSystem.Icons.footprint,
                    title: "닮은 동물",
                    actionTitle: "30실 받기"
                ),
                MyPageSubViewItemModel(
                    category: self,
                    icon: DesignSystem.Icons.ruler,
                    title: "키",
                    actionTitle: "30실 받기"
                )
            ]
        case .universityVerification:
            return [
                MyPageSubViewItemModel(
                    category: self,
                    icon: DesignSystem.Icons.eMail,
                    title: "학교 메일 인증",
                    actionTitle: "30실 받기"
                )
            ]
        }
    }
}
