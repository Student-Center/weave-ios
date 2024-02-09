//
//  SignUpGenderView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SignUpGenderView: View {
    let store: StoreOf<SignUpFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 56) {
                    genderSelectionView(.boy)
                    genderSelectionView(.girl)
                }
                .padding(.vertical, 50)
                
                
                Spacer()
                
                WeaveButton(
                    title: "다음으로",
                    size: .medium,
                    isEnabled: viewStore.selectedGender != nil
                ) {
                    viewStore.send(.didTappedNextButton)
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    @ViewBuilder
    func genderSelectionView(_ gender: GenderTypes) -> some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            let foregroundColor = viewStore.selectedGender == gender ? DesignSystem.Colors.defaultBlue : DesignSystem.Colors.lightGray
            
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
                viewStore.send(.didTappedGender(gender: gender))
            }
            
        }
    }
}

