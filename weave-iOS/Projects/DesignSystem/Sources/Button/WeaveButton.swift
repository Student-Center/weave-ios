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
    let isWeaveGraientBackground: Bool
    var icon: Image?
    var handler: (() -> Void)?
    @State private var isTouched: Bool = false
    
    //MARK: Pressed 상태를 기반으로 한 컬러값을 리턴
    var foregroundColor: Color {
        return style == .filled ? .white : buttonTintColor
    }
    
    var backgroundColor: Color {
        return style == .filled ? buttonTintColor : .clear
    }
    
    var textTintColor: Color {
        return isTouched ? DesignSystem.Colors.gray500 : textColor
    }
    
    var buttonTintColor: Color {
        return isTouched ? DesignSystem.Colors.gray500 : buttonBackgroundColor
    }
    
    public init(
        title: String,
        icon: Image? = nil,
        style: WeaveButtonStyle = .filled,
        size: ButtonSize = .regular,
        textColor: Color = DesignSystem.Colors.white,
        backgroundColor: Color = DesignSystem.Colors.defaultBlue,
        isWeaveGraientBackground: Bool = false,
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
        self.isWeaveGraientBackground = isWeaveGraientBackground
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
                    .foregroundColor(textTintColor)
                    .padding(.vertical, size.padding.height)
                Spacer()
            }
            .background(getBackgroundColor())
            .clipShape(Capsule())
            .overlay(
                ZStack {
                    Capsule()
                        .stroke(
                            foregroundColor,
                            lineWidth: style == .outline ? 1 : 0
                        )
                    if !isEnabled {
                        Capsule()
                            .foregroundStyle(.black.opacity(0.25))
                    }
                }
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
    
    
    private func getBackgroundColor() -> some View {
        if isWeaveGraientBackground {
            return AnyView(LinearGradient.weaveGradientReversed)
        } else {
            return AnyView(backgroundColor)
        }
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
        case tiny
        
        var font: Font {
            switch self {
            case .large: return .pretendard(._600, size: 16)
            case .medium: return .pretendard(._500, size: 16)
            case .regular: return .pretendard(._500, size: 15)
            case .small, .tiny: return .pretendard(._500, size: 12)
            }
        }
        
        var padding: CGSize {
            switch self {
            case .large: return .init(width: 24, height: 18)
            case .medium: return .init(width: 24, height: 14)
            case .regular: return .init(width: 24, height: 13)
            case .small: return .init(width: 24, height: 12)
            case .tiny: return .init(width: 24, height: 8)
            }
        }
    }
}
