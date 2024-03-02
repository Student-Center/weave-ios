//
//  LocationIconView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 3/2/24.
//

import SwiftUI

public struct LocationIconView: View {
    private let region: String
    
    public init(region: String) {
        self.region = region
    }
    
    public var body: some View {
        HStack(spacing: 5) {
            DesignSystem.Icons.mapMarker
            Text(region)
                .font(.pretendard(._600, size: 12))
        }
        .foregroundStyle(DesignSystem.Colors.defaultBlue)
    }
}
