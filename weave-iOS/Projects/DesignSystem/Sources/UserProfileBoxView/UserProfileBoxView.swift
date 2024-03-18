//
//  UserProfileBoxView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/19/24.
//

import SwiftUI
import CoreKit

public struct UserProfileBoxConfig {
    let mbti: MBTIType?
    let animal: AnimalTypes?
    let height: Int?
    let profileImage: String?
    let univName: String
    let majorName: String
    let birthYear: Int
    let isUnivVerified: Bool
    
    public init(
        mbti: MBTIType?,
        animal: AnimalTypes?,
        height: Int?,
        profileImage: String? = nil,
        univName: String,
        majorName: String,
        birthYear: Int,
        isUnivVerified: Bool
    ) {
        self.mbti = mbti
        self.animal = animal
        self.height = height
        self.profileImage = profileImage
        self.univName = univName
        self.majorName = majorName
        self.birthYear = birthYear
        self.isUnivVerified = isUnivVerified
    }
}

public struct UserProfileBoxView: View {
    
    let config: UserProfileBoxConfig
    
    public init(config: UserProfileBoxConfig) {
        self.config = config
    }
    
    var univVerifiedIcon: Image {
        config.isUnivVerified ? DesignSystem.Icons.certified : DesignSystem.Icons.nonCertified
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                if let mbti = config.mbti {
                    RoundCornerBoxedTextView(mbti.description)
                }
                if let animalType = config.animal {
                    RoundCornerBoxedTextView(animalType.text)
                }
                if let height = config.height {
                    RoundCornerBoxedTextView("📏 \(height)cm")
                }
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    HStack(spacing: 3) {
                        Text(config.univName)
                        univVerifiedIcon
                    }
                    Text(config.majorName)
                    Text("\(config.birthYear.toShortBirthYear())년생")
                }
                .font(.pretendard(._500, size: 16))
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(DesignSystem.Colors.lightGray)
            }
            .padding(.horizontal, 4)
        }
        .padding(.all, 12)
        .background(DesignSystem.Colors.darkGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .padding(.horizontal, 16)
        .frame(height: 180)
    }
}
