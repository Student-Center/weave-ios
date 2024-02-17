//
//  WeaveButton.swift
//  DesignSystem
//
//  Created by Jisu Kim on 1/20/24.
//

import SwiftUI

public struct WeaveButton: View {
    
    let title: String
    let isEnabled: Bool
    let style: WeaveButtonStyle
    let size: ButtonSize
    let textColor: Color
    let buttonBackgroundColor: Color
    var icon: Image?
    var handler: (() -> Void)?
    @State private var isTouched: Bool = false
    
    //MARK: Pressed 상태를 기반으로 한 컬러값을 리턴
    var foregroundColor: Color {
        return style == .filled ? .white : buttonTintColor
    }
    
    var backgroundColor: Color {
        return style == .filled ? buttonTintColor : .white
    }
    
    var buttonTintColor: Color {
        if !isEnabled {
            return DesignSystem.Colors.gray500
        }
        return isTouched ? DesignSystem.Colors.gray500 : DesignSystem.Colors.defaultBlue
    }
    
    public init(
        title: String,
        icon: Image? = nil,
        style: WeaveButtonStyle = .filled,
        size: ButtonSize = .regular,
        textColor: Color = DesignSystem.Colors.white,
        backgroundColor: Color = DesignSystem.Colors.defaultBlue,
        isEnabled: Bool = true,
        handler: (() -> Void)? = nil
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.size = size
        self.textColor = textColor
        self.buttonBackgroundColor = backgroundColor
        self.isEnabled = isEnabled
        self.handler = handler
    }
    
    public var body: some View {
        HStack {
            HStack(spacing: 3) {
                Spacer()
                
                if let icon = self.icon {
                    icon
                        .foregroundStyle(foregroundColor)
                }
                
                Text(title)
                    .font(size.font)
                    .foregroundColor(foregroundColor)
                    .padding(.vertical, size.padding.height)
                Spacer()
            }
            .background(backgroundColor)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(
                        foregroundColor,
                        lineWidth: style == .outline ? 1 : 0
                    )
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        isTouched = true
                    }
                    .onEnded { _ in
                        isTouched = false
                        handler?()
                    }
            )
            .disabled(!isEnabled)
        }
        .animation(.easeInOut(duration: 0.1), value: isTouched)
    }
}

extension WeaveButton {
    public enum WeaveButtonStyle {
        case filled
        case outline
    }
    
    public enum ButtonSize {
        case large
        case medium
        case regular
        case small
        
        var font: Font {
            switch self {
            case .large: return .pretendard(._600, size: 16)
            case .medium: return .pretendard(._500, size: 16)
            case .regular: return .pretendard(._500, size: 15)
            case .small: return .pretendard(._500, size: 12)
            }
        }
        
        var padding: CGSize {
            switch self {
            case .large: return .init(width: 24, height: 16)
            case .medium: return .init(width: 24, height: 14)
            case .regular: return .init(width: 24, height: 13)
            case .small: return .init(width: 24, height: 12)
            }
        }
    }
}
