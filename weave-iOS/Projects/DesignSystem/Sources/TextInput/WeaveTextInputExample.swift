//
//  WeaveTextInputExample.swift
//  DesignSystem
//
//  Created by Jisu Kim on 1/22/24.
//

import SwiftUI

struct WeaveTextInputExample: View {
    @State var text: String = ""
    @State var state: WeaveTextInput.ValidationState = .none
    
    var body: some View {
        WeaveTextInput(
            placeholder: "주소를 입력해주세요",
            text: $text,
            validationState: state,
            errorMessage: "잘못된 입력"
        )
        .padding()
        
        Button("에러토글") {
            if state == .none {
                state = .error
            } else if state == .error {
                state = .success
            } else {
                state = .none
            }
        }
    }
}

#Preview {
    WeaveTextInputExample()
}
