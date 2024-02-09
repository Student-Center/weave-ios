//
//  SignUpFeature.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/10/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Services

struct SignUpFeature: Reducer {
    struct State: Equatable {
        // 현단계 상태값
        var currentStep: SignUpStepTypes = .gender
        // 성별
        var selectedGender: GenderTypes?
        // 나이
        @BindingState var birthYear = String()
        // MBTI
        @BindingState var mbtiDatas = MBTIDataModel()
        // 학교
        @BindingState var universityText = String()
        var universityLists = [UniversityModel]()
        var filteredUniversityLists = [UniversityModel]()
        var selectedUniversity: UniversityModel?
        // 전공
        @BindingState var majorText = String()
        var majorLists = [MajorModel]()
        var filteredMajorLists = [MajorModel]()
        var selectedmajor: MajorModel?
    }
    
    enum Action: BindableAction {
        case didTappedGender(gender: GenderTypes)
        case didTappedNextButton
        case didTappedPreviousButton
        case requestUniversityLists
        case fetchUniversityLists(list: [UniversityResponseDTO])
        case didTappedUniversity(university: UniversityModel)
        case requestMajors
        case fetchMajorLists(list: [MajorResponseDTO])
        case didTappedMajors(major: MajorModel)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            
            // 대학교 목록 필터
            if state.currentStep == .school {
                state.filteredUniversityLists = filterUniversityDataSource(
                    dataSource: state.universityLists,
                    text: state.universityText
                )
                state.selectedUniversity = getMatchedUniversityModel(
                    dataSource: state.filteredUniversityLists,
                    text: state.universityText
                )
            }
            
            // 전공 목록 필터
            if state.currentStep == .major {
                state.filteredMajorLists = filterMajorDataSource(
                    dataSource: state.majorLists,
                    text: state.majorText
                )
                state.selectedmajor = getMatchedMajorModel(
                    dataSource: state.filteredMajorLists,
                    text: state.majorText
                )
            }
            
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
                    // Validation
                    guard let gender = state.selectedGender,
                          let mbti = state.mbtiDatas.value,
                          let birthYear = Int(state.birthYear),
                          let univ = state.selectedUniversity,
                          let major = state.selectedmajor else { return .none }
                    let requestDTO = RegisterUserRequestDTO(
                        gender: gender.value,
                        birthYear: birthYear,
                        mbti: mbti,
                        universityId: univ.id,
                        majorId: major.id
                    )
                    return .run { send in
                        try await requestRegisterUser(dto: requestDTO)
                    } catch: { error, send in
                        print(error)
                    }
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
                    let universityLists = try await requestUniversityLists()
                    await send.callAsFunction(.fetchUniversityLists(list: universityLists))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchUniversityLists(let universityLists):
                let dataSource = universityLists.map { $0.toDomain }
                state.universityLists = dataSource
                state.filteredUniversityLists = dataSource
                return .none
                
            case .didTappedUniversity(let university):
                state.selectedUniversity = university
                state.universityText = university.name
                return .none
                
            case .requestMajors:
                // 초기화
                state.majorText = ""
                state.majorLists = []
                state.filteredMajorLists = []
                state.selectedmajor = nil
                return .run { [univId = state.selectedUniversity?.id] send in
                    guard let univId else { return }
                    let majorList = try await requestMajorLists(univId: univId)
                    await send.callAsFunction(.fetchMajorLists(list: majorList))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchMajorLists(let list):
                let dataSource = list.map { $0.toDomain }
                state.majorLists = dataSource
                state.filteredMajorLists = dataSource
                return .none
                
            case .didTappedMajors(let major):
                state.selectedmajor = major
                state.majorText = major.name
                return .none
                
            default: return .none
            }
        }
    }
    
    // 학교 리스트 불러오기
    private func requestUniversityLists() async throws -> [UniversityResponseDTO] {
        let endPoint = APIEndpoints.getUniversityInfo()
        let provider = APIProvider(session: URLSession.shared)
        let response: UniversitiesResponseDTO = try await provider.request(with: endPoint)
        return response.universities
    }
                         
    // 전공 리스트 불러오기
    private func requestMajorLists(univId: String) async throws -> [MajorResponseDTO] {
        let endPoint = APIEndpoints.getMajorInfo(univId: univId)
        let provider = APIProvider(session: URLSession.shared)
        let response: MajorsResponseDTO = try await provider.request(with: endPoint)
        return response.majors
    }
    
    // 회원가입 요청
    private func requestRegisterUser(dto: RegisterUserRequestDTO) async throws {
        let endPoint = APIEndpoints.registerUser(registerToken: "", body: dto)
        let provider = APIProvider(session: URLSession.shared)
        let response: TempTokenResponseDTO = try await provider.request(with: endPoint)
    }
    
    // 포함하는 데이터 소스로 정렬해 리턴
    private func filterUniversityDataSource(dataSource: [UniversityModel], text: String) -> [UniversityModel] {
        if text == "" { return dataSource }
        return dataSource.filter { $0.name.contains(text) }
    }
    
    private func getMatchedUniversityModel(dataSource: [UniversityModel], text: String) -> UniversityModel? {
        for data in dataSource {
            if data.name == text {
                return data
            }
        }
        return nil
    }
    
    private func filterMajorDataSource(dataSource: [MajorModel], text: String) -> [MajorModel] {
        if text == "" { return dataSource }
        return dataSource.filter { $0.name.contains(text) }
    }
    
    private func getMatchedMajorModel(dataSource: [MajorModel], text: String) -> MajorModel? {
        for data in dataSource {
            if data.name == text {
                return data
            }
        }
        return nil
    }
}

extension SignUpFeature {
    
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
    
    enum GenderTypes {
        case boy
        case girl
        
        var icon: Image {
            switch self {
            case .boy: return DesignSystem.Icons.boy
            case .girl: return DesignSystem.Icons.girl
            }
        }
        
        var title: String {
            switch self {
            case .boy: return "남성"
            case .girl: return "여성"
            }
        }
        
        var value: String {
            switch self {
            case .boy: return "MAN"
            case .girl: return "WOMAN"
            }
        }
    }

    struct MBTIDataModel: Equatable {
        var EorI: String?
        var NorS: String?
        var ForT: String?
        var PorJ: String?
        
        var value: String? {
            guard let EorI,
                  let NorS,
                  let ForT,
                  let PorJ else { return nil }
            
            return EorI + NorS + ForT + PorJ
        }
        
        func validate() -> Bool {
            return [EorI, NorS, ForT, PorJ]
                .allSatisfy { $0 != nil }
        }
    }
}
