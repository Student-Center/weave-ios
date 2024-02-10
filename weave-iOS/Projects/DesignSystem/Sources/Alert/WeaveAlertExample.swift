//
//  WeaveAlertExample.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/10/24.
//

import SwiftUI

struct WeaveAlertExample: View {
    
    @State var isMailAlertShow = false
    @State var isOfflineCheckAlertShow = false
    
    var body: some View {
        VStack {
            Text("Alert 테스트 뷰")
                .font(.pretendard(._800, size: 35))
            Spacer()
            
            HStack(spacing: 15) {
                WeaveButton(
                    title: "메일 인증",
                    style: .filled,
                    size: .medium) {
                        isMailAlertShow.toggle()
                    }
                    .frame(width: 150)
                    .weaveAlert(
                        isPresented: $isMailAlertShow,
                        title: "🚀\n학교 메일 인증",
                        message: "인증 메일이 발송되었어요.\n메일을 확인해 인증을 완료해 주세요.",
                        primaryButtonTitle: "확인",
                        secondaryButtonTitle: "취소",
                        primaryAction: {
                            print("확인 버튼 액션")
                        },
                        secondaryAction: {
                            print("취소 버튼 액션")
                        }
                    )
                
                WeaveButton(
                    title: "로그아웃",
                    style: .filled,
                    size: .medium) {
                        print("탭!")
                        isOfflineCheckAlertShow.toggle()
                    }
                    .frame(width: 150)
                    .weaveAlert(
                        isPresented: $isOfflineCheckAlertShow,
                        title: "로그아웃 하시겠어요?",
                        primaryButtonTitle: "네, 할래요",
                        secondaryButtonTitle: "아니요",
                        primaryAction: {
                            print("로그아웃 액션")
                        },
                        secondaryAction: {
                            print("취소 버튼 액션")
                        }
                    )
                
            }
            Spacer()
                .frame(height: 250)
        }
    }
}

#Preview {
    WeaveAlertExample()
}
