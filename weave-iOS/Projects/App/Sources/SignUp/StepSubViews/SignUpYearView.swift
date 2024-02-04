//
//  SignUpYearView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import DesignSystem

struct SignUpYearView: View {
    @State var yearText = String()
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                WeaveTextField(
                    text: $yearText,
                    placeholder: "YYYY",
                    font: .pretendard(._600, size: 20),
                    textAlignment: .center,
                    keyboardType: .numberPad
                )
                .frame(width: 100)
                Text("년")
                    .font(.pretendard(._600, size: 20))
            }
            
            Text("프로필에 표시되는 나이를 위한 정보 수집으로,\n회원가입 이후 변경할 수 없어요!")
                .font(.pretendard(._400, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(DesignSystem.Colors.white)
                .padding(.vertical, 11)
        }
    }
}

#Preview {
    SignUpYearView()
}
