//
//  SignUpView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import DesignSystem

struct SignUpView: View {
    
    @State var currentStep: SignUpStepTypes = .gender
    
    var body: some View {
        NavigationStack {
            VStack {
                WeaveStepper(
                    maxStepCount: 5,
                    currentStep: currentStep.rawValue
                )
                Spacer()
                    .frame(height: 30)
                
                Text(currentStep.title)
                    .multilineTextAlignment(.center)
                    .font(.pretendard(._500, size: 22))
                    .frame(height: 100)
                
                switch currentStep {
                case .gender:
                    SignUpGenderView()
                case .year:
                    SignUpYearView()
                case .mbti:
                    Text("MBTI")
                case .university:
                    Text("University")
                case .major:
                    Text("Major")
                }
                
                Spacer()
                
                WeaveButton(
                    title: "다음으로",
                    size: .medium
                ) {
                    let nextRawValue = currentStep.rawValue + 1
                    if let nextStep = SignUpStepTypes(rawValue: nextRawValue) {
                        currentStep = nextStep
                    } else {
                        print("완료")
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 1)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        let previousRawValue = currentStep.rawValue - 1
                        if let previousStep = SignUpStepTypes(rawValue: previousRawValue) {
                            currentStep = previousStep
                        } else {
                            print("없음")
                        }
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    })
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}

enum SignUpStepTypes: Int {
    case gender = 0
    case year = 1
    case mbti = 2
    case university = 3
    case major = 4
    
    var title: String {
        switch self {
        case .gender:
            return "반가워요✋\n성별이 무엇인가요?"
        case .year:
            return "출생년도를 알려주세요"
        case .mbti:
            return "성격 유형이 무엇인가요?"
        case .university:
            return "어느 대학교에 다니시나요?"
        case .major:
            return "어떤 학과를 전공하고 계시나요?"
        }
    }
}
