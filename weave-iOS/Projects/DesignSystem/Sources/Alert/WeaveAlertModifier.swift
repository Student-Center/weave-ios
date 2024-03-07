//
//  WeaveAlertModifier.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/10/24.
//

import SwiftUI

public struct WeaveAlertModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    
    let weaveAlert: WeaveAlert
    
    public func body(content: Content) -> some View {
        content
            .transparentFullScreenCover(isPresented: $isPresented) {
                weaveAlert
            }
            .transaction({ transaction in
                transaction.disablesAnimations = true
//                transaction.animation = .linear(duration: 0.5)
            })
    }
}

public extension View {
    func weaveAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryButtonTitle: String,
        primaryButtonColor: Color = DesignSystem.Colors.defaultBlue,
        secondaryButtonTitle: String? = nil,
        primaryAction: (() -> Void)? = nil,
        secondaryAction: (() -> Void)? = nil
    ) -> some View {
        let alert = WeaveAlert(
            isPresented: isPresented,
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryButtonColor: primaryButtonColor,
            secondaryButtonTitle: secondaryButtonTitle,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )
        return modifier(WeaveAlertModifier(isPresented: isPresented, weaveAlert: alert))
    }
}

