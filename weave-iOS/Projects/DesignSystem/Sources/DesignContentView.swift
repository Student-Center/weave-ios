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
            Text("Title")
                .font(._title)
            Text("Header1")
                .font(._header1)
            Text("Header2")
                .font(._header2)
            Text("Header3")
                .font(._header3)
            Text("body1_medium")
                .font(._body1_medium)
            Text("body1_regular")
                .font(._body1_regular)
            Text("body2_medium")
                .font(._body2_medium)
            Text("body2_regular")
                .font(._body2_regular)
            Text("button16")
                .font(._button16)
            Text("button14")
                .font(._button14)
            Text("body3")
                .font(._body3)
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                generateBox()
                    .foregroundStyle(DesignSystem.purple)
                generateBox()
                    .foregroundStyle(DesignSystem.sky)
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
