//
//  ViewOnLoad.swift
//  Services
//
//  Created by Jisu Kim on 3/23/24.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: () -> Void

    init(perform action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action()
            }
        }
    }
}

extension View {
    public func onLoad(perform action: @escaping () -> Void) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
