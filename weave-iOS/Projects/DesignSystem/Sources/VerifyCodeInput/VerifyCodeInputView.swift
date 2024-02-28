//
//  VerifyCodeInputView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/21/24.
//

import SwiftUI

public struct VerifyCodeInputView: View {
    
    @Binding var verifyCode: String
    @Binding var errorMessage: String?
    var verifyCodeMaxCount: Int
    @FocusState private var isTextFieldFocused: Bool
    
    public init(
        verifyCode: Binding<String>,
        errorMessage: Binding<String?>,
        verifyCodeMaxCount: Int = 6
    ) {
        self._verifyCode = verifyCode
        self._errorMessage = errorMessage
        self.verifyCodeMaxCount = verifyCodeMaxCount
    }
        
    public var body: some View {
        ZStack(alignment: .center) {
            textBoxHStackView
            clearTextFieldView
        }
    }
    
    private var textBoxHStackView: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< verifyCodeMaxCount, id: \.self) { index in
                let text = getCharFromString(index: index)
                getSingleTextBox(text: text)
            }
        }
    }
    
    @ViewBuilder
    private func getSingleTextBox(text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(text.isEmpty ? DesignSystem.Colors.lightGray : .white, lineWidth: 1)
                .background(DesignSystem.Colors.darkGray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(text)
                .font(.pretendard(._500, size: 32))
        }
        .frame(width: 45, height: 56)
    }
    
    private var clearTextFieldView: some View {
        TextField("", text: $verifyCode)
            .focused($isTextFieldFocused)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .onChange(of: verifyCode) { oldValue, newValue in
                if newValue.count == 6 {
                    isTextFieldFocused = false
                }
            }
            .keyboardType(.numberPad)
            .onTapGesture {
                verifyCode = ""
                isTextFieldFocused = true
            }
    }
    
    private func getCharFromString(index: Int) -> String {
        if index >= verifyCode.count {
            return ""
        }
        let numArray = verifyCode.compactMap { Int(String($0)) }
        return String(numArray[index])
    }
}
