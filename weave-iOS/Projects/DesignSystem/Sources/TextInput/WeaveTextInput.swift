//
//  WeaveTextInput.swift
//  DesignSystem
//
//  Created by Jisu Kim on 1/20/24.
//

import SwiftUI

public struct WeaveTextInput: View {
    @Binding var text: String
    let validationState: ValidationState
    
    let placeholder: String
    let needSecureToggle: Bool
    let errorMessage: String?
    
    @FocusState private var isFocused: Bool
    @State var isEnabled = false
    @State var isSecureMode: Bool
    
    var foregroundColor: Color {
        return DesignSystem.Colors.gray900
    }
    
    public init(
        placeholder: String,
        needSecureToggle: Bool = false,
        text: Binding<String>,
        validationState: WeaveTextInput.ValidationState = .none,
        errorMessage: String? = nil
    ) {
        self.placeholder = placeholder
        self.needSecureToggle = needSecureToggle
        self.isSecureMode = needSecureToggle
        self._text = text
        self.validationState = validationState
        self.errorMessage = errorMessage
    }
    
    public var body: some View {
        VStack {
            HStack {
                // 텍스트필드
                if isSecureMode {
                    SecureField(placeholder, text: $text)
                        .font(.pretendard(._500, size: 16))
                        .focused($isFocused)
                } else {
                    TextField(placeholder, text: $text)
                        .font(.pretendard(._500, size: 16))
                        .focused($isFocused)
                }
                // Secure 토글 버튼
                if needSecureToggle {
                    Button(action: {
                        isSecureMode.toggle()
                    }, label: {
                        Image(
                            systemName: isSecureMode ? "eye" : "eye.slash"
                        )
                        .foregroundStyle(DesignSystem.Colors.gray500)
                    })
                }
                // State에 따른 icon
                if let icon = validationState.icon {
                    icon
                        .foregroundStyle(validationState.foregroundColor)
                }
                
                // clear 버튼
                if !isSecureMode && validationState == .none && !text.isEmpty {
                    Button(action: {
                        text = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(DesignSystem.Colors.gray500)
                    })
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .inset(by: 1)
                    .stroke(validationState.getStrokeColor(isFocused),
                            lineWidth: 1
                           )
                    .foregroundColor(.clear)
            )
            // 에러메시지
            if let errorMessage {
                HStack {
                    // 에러인 경우에만 메시지 입력, 이외에는 자리만 차지하도록
                    let message = validationState == .error ? errorMessage : ""
                    Text(message)
                        .font(.pretendard(._500, size: 12))
                        .foregroundStyle(validationState.foregroundColor)
                    Spacer()
                }
                .frame(height: 18)
            }
        }
    }
}

extension WeaveTextInput {
    public enum ValidationState {
        case none
        case error
        case success
        
        var foregroundColor: Color {
            switch self {
            case .none: return DesignSystem.Colors.gray500
            case .error: return Color(red: 255, green: 0, blue: 34)
            case .success: return Color(red: 37, green: 211, blue: 102)
            }
        }
        
        var icon: Image? {
            switch self {
            case .none:
                return nil
            case .error:
                return Image(systemName: "exclamationmark.circle.fill")
            case .success:
                return Image(systemName: "checkmark.circle.fill")
            }
        }
        
        func getStrokeColor(_ isFocused: Bool) -> Color {
            if self == .none {
                return isFocused ? .black : foregroundColor
            }
            return foregroundColor
        }
    }
}

#Preview {
    HStack {
        Spacer()
            .frame(width: 50)
        WeaveTextInput(placeholder: "이름", text: .constant("김지수"))
        Spacer()
            .frame(width: 50)
    }
}
