//
//  CapsuleView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/2/24.
//

import SwiftUI

public struct RoundCornerBoxedTextView: View {
    private let title: String
    private let backgroundColor: Color
    
    public init(
        _ title: String,
        tintColor: Color = DesignSystem.Colors.lightGray
    ) {
        self.title = title
        self.backgroundColor = tintColor
    }
    
    public var body: some View {
        ZStack {
            Text(title)
                .font(.pretendard(._500, size: 12))
                .foregroundStyle(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 12)
        }
        .background(backgroundColor)
        .clipShape(
            RoundedRectangle(cornerRadius: 5)
        )
    }
}
