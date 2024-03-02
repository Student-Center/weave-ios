//
//  CenterTitleView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/27/24.
//

import SwiftUI

public struct CenterTitleView: View {
    
    let title: String
    var dismissHandler: () -> Void
    
    public init(title: String, dismissHandler: @escaping () -> Void) {
        self.title = title
        self.dismissHandler = dismissHandler
    }
    
    public var body: some View {
        ZStack {
            Text(title)
                .font(.pretendard(._600, size: 20))
            HStack {
                Spacer()
                Button(action: {
                    dismissHandler()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
                .foregroundStyle(DesignSystem.Colors.lightGray)
            }
        }
        .padding(.top, 36)
        .padding(.bottom, 20)
        .padding(.horizontal, 16)
    }
}

