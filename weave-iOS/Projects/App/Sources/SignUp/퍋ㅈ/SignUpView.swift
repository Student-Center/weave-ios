//
//  SignUpView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct SignUpView: View {
    
    let store: StoreOf<SignUpFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    WeaveStepper(
                        maxStepCount: 5,
                        currentStep: viewStore.currentStep.rawValue
                    )
                    Spacer()
                        .frame(height: 30)
                    
                    Text(viewStore.currentStep.title)
                        .multilineTextAlignment(.center)
                        .font(.pretendard(._500, size: 22))
                        .frame(height: 100)
                    
                    switch viewStore.currentStep {
                    case .gender:
                        SignUpGenderView(store: store)
                    case .year:
                        SignUpYearView(store: store)
                    case .mbti:
                        SignUpMBTIView(store: store)
                    case .school:
                        SignUpSchoolView(store: store)
                            .zIndex(1000)
                    case .major:
                        SignUpMajorView(store: store)
                            .zIndex(1000)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 1)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            viewStore.send(.didTappedPreviousButton)
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
}

#Preview {
    SignUpView(
        store: Store(
            initialState: SignUpFeature.State()) {
                SignUpFeature()
            }
    )
}
