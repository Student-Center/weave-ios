//
//  SignUpView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import Services
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
                        SignUpMajorView()
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

struct SignUpFeature: Reducer {
    struct State: Equatable {
        var currentStep: SignUpStepTypes = .gender
        @BindingState var birthYear = String()
        var selectedGender: SignUpGenderView.GenderTypes?
        @BindingState var mbtiDatas = MBTIDataModel()
        var universityLists = [UniversityResponseDTO]()
    }
    
    enum Action: BindableAction {
        case didTappedGender(gender: SignUpGenderView.GenderTypes)
        case didTappedNextButton
        case didTappedPreviousButton
        case requestUniversityLists
        case fetchUniversityLists(list: [UniversityResponseDTO])
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTappedGender(let gender):
                state.selectedGender = gender
                return .none
                
            case .didTappedNextButton:
                let nextRawValue = state.currentStep.rawValue + 1
                if let nextStep = SignUpStepTypes(rawValue: nextRawValue) {
                    withAnimation(.snappy) {
                        state.currentStep = nextStep
                    }
                } else {
                    print("완료")
                }
                return .none
                
            case .didTappedPreviousButton:
                let previousRawValue = state.currentStep.rawValue - 1
                if let previousStep = SignUpStepTypes(rawValue: previousRawValue) {
                    state.currentStep = previousStep
                } else {
                    print("없음")
                }
                return .none
                
            case .requestUniversityLists:
                return .run { send in
                    let universityLists = try await requestSchoolLists()
                    print(universityLists)
                    await send.callAsFunction(.fetchUniversityLists(list: universityLists))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchUniversityLists(let universityLists):
                state.universityLists = universityLists
                return .none
                
            default: return .none
            }
        }
    }
    
    private func requestSchoolLists() async throws -> [UniversityResponseDTO] {
        let endPoint = APIEndpoints.getUniversitiesInfo()
        let provider = APIProvider(session: URLSession.shared)
        // APIProvider의 request 함수를 호출하고 결과를 디코딩하여 반환
        let response: UniversitiesResponseDTO = try await provider.request(with: endPoint)
        return response.universities
    }
}

extension SignUpFeature {
    struct MBTIDataModel: Equatable {
        var EorI: String?
        var NorS: String?
        var ForT: String?
        var PorJ: String?
        
        func validate() -> Bool {
            return [EorI, NorS, ForT, PorJ]
                .allSatisfy { $0 != nil }
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

enum SignUpStepTypes: Int {
    case gender = 0
    case year = 1
    case mbti = 2
    case school = 3
    case major = 4
    
    var title: String {
        switch self {
        case .gender:
            return "반가워요✋\n성별이 무엇인가요?"
        case .year:
            return "출생년도를 알려주세요"
        case .mbti:
            return "성격 유형이 무엇인가요?"
        case .school:
            return "어느 대학교에 다니시나요?"
        case .major:
            return "어떤 학과를 전공하고 계시나요?"
        }
    }
}
