//
//  LocationIconView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/2/24.
//

import SwiftUI

public struct LocationIconView: View {
    private let region: String
    private let tintColor: Color
    
    public init(
        region: String,
        tintColor: Color = DesignSystem.Colors.defaultBlue
    ) {
        self.region = region
        self.tintColor = tintColor
    }
    
    public var body: some View {
        HStack(spacing: 5) {
            DesignSystem.Icons.mapMarker
            Text(region)
                .font(.pretendard(._600, size: 12))
        }
        .foregroundStyle(tintColor)
    }
}
