//
//  WeaveStepper.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/4/24.
//

import Foundation
import SwiftUI

public struct WeaveStepper: View {
    
    let maxStepCount: Int
    let currentStep: Int
    
    public init(
        maxStepCount: Int,
        currentStep: Int
    ) {
        self.maxStepCount = maxStepCount
        self.currentStep = currentStep
    }
    
    public var body: some View {
        HStack(spacing: 3) {
            ForEach(0 ..< maxStepCount, id: \.self) { index in
                if currentStep < index {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(DesignSystem.Colors.darkGray)
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
        let start = CGFloat(1) / CGFloat(maxStepCount) * CGFloat(index)
        let end = CGFloat(1) / CGFloat(maxStepCount) * CGFloat(index + 1)
        
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

//#Preview {
//    WeaveStepper(
//        maxStepCount: 5,
//        currentStep: 2
//    )
//}
