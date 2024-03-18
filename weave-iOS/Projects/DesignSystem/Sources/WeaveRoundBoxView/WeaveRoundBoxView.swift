//
//  WeaveRoundBoxView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/15/24.
//

import SwiftUI

struct WeaveRoundBoxView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 19)
            .padding([.top, .leading, .trailing], 12)
            .background(DesignSystem.Colors.darkGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

public extension View {
    func weaveBoxStyle() -> some View {
        modifier(WeaveRoundBoxView())
    }
}
