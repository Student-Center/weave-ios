//
//  TransparentBackground.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/10/24.
//

import SwiftUI

fileprivate struct TransparentBackground: UIViewRepresentable {
    
    fileprivate func makeUIView(context: Context) -> UIView {
        
        let view = TransparentBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    fileprivate func updateUIView(_ uiView: UIView, context: Context) {}
}

private class TransparentBackgroundView: UIView {
    open override func layoutSubviews() {
        guard let parentView = superview?.superview else {
            return
        }
        parentView.backgroundColor = .clear
    }
}

public extension View {
    /// 투명 배경으로 FullScreenCover를 show 합니다.
    func transparentFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
}
