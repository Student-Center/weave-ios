//
//  WeaveStepper.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/4/24.
//

import Foundation
import SwiftUI

struct WeaveStepper: View {
    
    let maxCount: Int
    let currentIndex: Int
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0 ..< maxCount, id: \.self) { index in
                if currentIndex < index {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(DesignSystem.darkGray)
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(
                            processGradient(index: index)
                        )
                }
            }
        }
        .frame(height: 8)
    }
    
    func processGradient(index: Int) -> some ShapeStyle {
        let start = CGFloat(1) / CGFloat(maxCount) * CGFloat(index)
        let end = CGFloat(1) / CGFloat(maxCount) * CGFloat(index + 1)
        
        return LinearGradient(
            colors: [
                .weaveGradientColors.colorAtPoint(at: start),
                .weaveGradientColors.colorAtPoint(at: end)
            ],
            startPoint: UnitPoint(x: 0.0, y: 0.5),
            endPoint: UnitPoint(x: 1, y: 0.5)
        )
    }
}

#Preview {
    WeaveStepper(
        maxCount: 5,
        currentIndex: 2
    )
}
