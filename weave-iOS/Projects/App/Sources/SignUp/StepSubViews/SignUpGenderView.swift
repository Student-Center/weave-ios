//
//  SignUpGenderView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import DesignSystem

struct SignUpGenderView: View {
    enum GenderTypes {
        case boy
        case girl
        
        var icon: Image {
            switch self {
            case .boy: return DesignSystem.Icons.boy
            case .girl: return DesignSystem.Icons.girl
            }
        }
        
        var title: String {
            switch self {
            case .boy: return "남성"
            case .girl: return "여성"
            }
        }
    }
    
    @State var selectedGender: GenderTypes?
    
    var body: some View {
        VStack {
            HStack(spacing: 56) {
                genderSelectionView(.boy)
                genderSelectionView(.girl)
            }
            .padding(.vertical, 50)
        }
    }
    
    @ViewBuilder
    func genderSelectionView(_ gender: GenderTypes) -> some View {
        let foregroundColor = self.selectedGender == gender ? DesignSystem.Colors.defaultBlue : DesignSystem.Colors.lightGray
        
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 2)
                    .frame(width: 108, height: 108)
                    .foregroundStyle(foregroundColor)
                    .background(DesignSystem.Colors.darkGray)
                    .clipShape(Circle())
                
                gender.icon
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            
            Text(gender.title)
                .font(.pretendard(._500, size: 20))
                .foregroundStyle(foregroundColor)
        }
        .onTapGesture {
            self.selectedGender = gender
        }
    }
}

