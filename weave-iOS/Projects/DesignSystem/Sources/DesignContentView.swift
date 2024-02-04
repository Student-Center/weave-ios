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
                    .foregroundStyle(DesignSystem.defaultPurple)
                generateBox()
                    .foregroundStyle(DesignSystem.defaultBlue)
                generateBox()
                    .foregroundStyle(DesignSystem.black)
                generateBox()
                    .foregroundStyle(DesignSystem.gray900)
                generateBox()
                    .foregroundStyle(DesignSystem.gray800)
                generateBox()
                    .foregroundStyle(DesignSystem.gray700)
            }
            
            HStack {
                generateBox()
                    .foregroundStyle(DesignSystem.gray600)
                generateBox()
                    .foregroundStyle(DesignSystem.gray500)
                generateBox()
                    .foregroundStyle(DesignSystem.gray400)
                generateBox()
                    .foregroundStyle(DesignSystem.gray300)
                generateBox()
                    .foregroundStyle(DesignSystem.gray200)
                generateBox()
                    .foregroundStyle(DesignSystem.white)
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
