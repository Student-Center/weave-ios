//
//  MyMbtiEditView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/26/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct MyMbtiEditView: View {
    
    let store: StoreOf<MyMbtiEditFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ZStack {
                    Text("내 MBTI는 ?")
                        .font(.pretendard(._600, size: 20))
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                        })
                        .foregroundStyle(DesignSystem.Colors.lightGray)
                    }
                }
                .padding(.horizontal, 16)

                ScrollView {
                    VStack {
                        MBTIPickerView(model: viewStore.$mbtiDataModel)
                    }
                    .padding(.horizontal, 16)
                }
                WeaveButton(title: "저장하기", size: .large) {
                    viewStore.send(.didTappedSaveButton)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview(body: {
    MyMbtiEditView(
        store: Store(
            initialState: MyMbtiEditFeature.State(
                mbtiDataModel: MBTIDataModel(mbti: "ESTJ")),
            reducer: {
        MyMbtiEditFeature()
    }))
})
