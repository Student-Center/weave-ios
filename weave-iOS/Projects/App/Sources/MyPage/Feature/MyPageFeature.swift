//
//  MyPageCore.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/16/24.
//

import SwiftUI
import ComposableArchitecture
import Services
import AVFoundation

struct MyPageFeature: Reducer {
    struct State: Equatable {
        var myUserInfo: MyUserInfoModel?
        @BindingState var isShowEditProfileImageAlert: Bool = false
        @BindingState var isShowPhotoPicker: Bool = false
        @BindingState var isShowCamera: Bool = false
        @BindingState var isShowCameraPermissionAlert: Bool = false
        
        @PresentationState var destination: Destination.State?
    }
    
    enum Action: BindableAction {
        case requestMyUserInfo
        case fetchMyUserInfo(userInfo: MyUserInfoResponseDTO)
        case didTappedPreferenceButton
        case didTappedProfileView
        case didTappedProfileEditButton
        case didTappedSubViews(view: MyPageCategoryTypes.MyPageSubViewTypes)
        case showPhotoPicker
        case didTappedShowCamera
        case didCameraPermissionDenied
        case showCamera
        case showAppPreference
        case didPickPhotoCompleted(image: Image)
        case destination(PresentationAction<Destination.Action>)
        // bind
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .requestMyUserInfo:
                return .run { send in
                    let myUserInfo = try await requestMyUserInfo()
                    await send.callAsFunction(.fetchMyUserInfo(userInfo: myUserInfo))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchMyUserInfo(let userInfo):
                state.myUserInfo = userInfo.toDomain
                print(userInfo.toDomain)
                return .none
                
            case .didTappedPreferenceButton:
                return .none
                
            case .didTappedProfileView:
                return .none
                
            case .didTappedProfileEditButton:
                state.isShowEditProfileImageAlert.toggle()
                return .none
                
            case .didTappedSubViews(let type):
                switch type {
                case .mbti:
                    state.destination = .editMbti(
                        .init(
                            mbtiDataModel: .init(
                                mbti: state.myUserInfo?.mbti ?? ""
                            )
                        )
                    )
                case .physicalHeight:
                    state.destination = .editHeight(
                        .init(
                            height: state.myUserInfo?.height
                        )
                    )
                case .similarAnimal:
                    state.destination = .editAnimal(
                        .init(
                            selectedAnimal: AnimalTypes(
                                rawValue: state.myUserInfo?.animalType ?? ""
                            )
                        )
                    )
                default: break
                }
                return .none
                
            case .destination(.dismiss):
                state.destination = nil
                return .run { send in
                    await send.callAsFunction(.requestMyUserInfo)
                }
                
            case .showPhotoPicker:
                state.isShowPhotoPicker.toggle()
                return .none
                
            case .didTappedShowCamera:
                return .run { send in
                    // 카메라 권한 상태 가지고 보내기
                    let cameraPermission = await checkCameraAuthorization()
                    if cameraPermission {
                        await send.callAsFunction(.showCamera)
                    } else {
                        await send.callAsFunction(.didCameraPermissionDenied)
                    }
                }
                
            case .showCamera:
                state.isShowCamera.toggle()
                return .none
                
            case .didCameraPermissionDenied:
                state.isShowCameraPermissionAlert.toggle()
                return .none
                
            case .didPickPhotoCompleted(let image):
                // 프로필 이미지 변경 필요
                print(image)
                return .none
                
            case .showAppPreference:
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
                return .none
                
            case .binding(_):
                return .none
                
            default: return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
    
    func requestMyUserInfo() async throws -> MyUserInfoResponseDTO {
        let endPoint = APIEndpoints.getMyUserInfo()
        let provider = APIProvider(session: URLSession.shared)
        let response = try await provider.request(with: endPoint)
        return response
    }
    
    func checkCameraAuthorization() async -> Bool {
        //권한 여부 확인
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .authorized {
            return true
        } else if status == .notDetermined {
            return await AVCaptureDevice.requestAccess(for: .video)
        } else {
            return false
        }
    }
}

//MARK: - Destination
extension MyPageFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case editMbti(MyMbtiEditFeature.State)
            case editAnimal(MyAnimalSelectionFeature.State)
            case editHeight(MyHeightEditFeature.State)
        }
        enum Action {
            case editMbti(MyMbtiEditFeature.Action)
            case editAnimal(MyAnimalSelectionFeature.Action)
            case editHeight(MyHeightEditFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.editMbti, action: /Action.editMbti) {
                MyMbtiEditFeature()
            }
            Scope(state: /State.editAnimal, action: /Action.editAnimal) {
                MyAnimalSelectionFeature()
            }
            Scope(state: /State.editHeight, action: /Action.editHeight) {
                MyHeightEditFeature()
            }
        }
    }
}
