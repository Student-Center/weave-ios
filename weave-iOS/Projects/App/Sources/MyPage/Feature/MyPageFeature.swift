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
                default: break
                }
                return .none
                
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
            }
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
