//
//  DesignContentView.swift
//  CoreManifests
//
//  Created by Jisu Kim on 1/14/24.
//

import SwiftUI

struct DesignContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.defaultPurple)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.defaultBlue)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.black)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray900)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray800)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray700)
            }
            
            HStack {
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray600)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray500)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray400)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray300)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.gray200)
                generateBox()
                    .foregroundStyle(DesignSystem.Colors.white)
            }
        }
    }
    
    @ViewBuilder
    func generateBox() -> some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 40)
    }
}

#Preview {
    DesignContentView()
}
