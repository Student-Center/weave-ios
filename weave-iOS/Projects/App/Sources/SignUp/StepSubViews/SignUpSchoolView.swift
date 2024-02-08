//
//  SignUpSchoolView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SignUpSchoolView: View {
    
    let store: StoreOf<SignUpFeature>
    
    @State var text = String()
    @State var showDropDown: Bool = false
    @State var selectedSchool: (any WeaveDropDownFetchable)?
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                WeaveDropDownPicker(
                    selectedItem: $selectedSchool,
                    dataSources: SchoolModel.mockUp()
                ) {
                    WeaveTextField(
                        text: .constant(selectedSchool?.name ?? ""),
                        placeholder: "위브대학교",
                        showClearButton: true
                    )
                }
                
                Spacer()
                
                WeaveButton(
                    title: "다음으로",
                    size: .medium,
                    isEnabled: viewStore.mbtiDatas.validate()
                ) {
                    viewStore.send(.didTappedNextButton)
                }
                .padding(.bottom, 20)
            }
            .onAppear {
                viewStore.send(.requestUniversityLists)
            }
        }
    }
}

struct SchoolModel: WeaveDropDownFetchable {
    let id: String
    let name: String
    let domainAddress: String
    let logoAddress: String
    
    static func mockUp() -> [SchoolModel] {
        return [
            SchoolModel(
                id: "018d7404-04f8-7a1f-905a-3f30b31426ad",
                name: "건국대학교",
                domainAddress: "konkuk.ac.kr",
                logoAddress: "public/university/018d7404-04f8-7a1f-905a-3f30b31426ad/logo"
            ),
            SchoolModel(
                id: "018d7404-04f8-7a1f-905a-3f30b31426ae",
                name: "단국대학교",
                domainAddress: "dankook.ac.kr",
                logoAddress: "public/university/018d7404-04f8-7a1f-905a-3f30b31426ae/logo"
            ),
            SchoolModel(
                id: "018d7404-04f9-76c2-aecc-5ecbcb0705c9",
                name: "명지대학교",
                domainAddress: "mju.ac.kr",
                logoAddress: "public/university/018d7404-04f9-76c2-aecc-5ecbcb0705c9/logo"
            ),
        ]
    }
}

struct MajorModel: WeaveDropDownFetchable {
    let id: String
    let name: String
    
    static func mockUp() -> [MajorModel] {
        return [
            MajorModel(
                id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                name: "간호학과"
            ),
            MajorModel(
                id: "3fa85f64-5717-4562-b3fc-2c963f66afa1",
                name: "경영학과"
            ),
            MajorModel(
                id: "3fa85f64-5717-4562-b3fc-2c963f66afa2",
                name: "컴퓨터공학과"
            ),
            MajorModel(
                id: "3fa85f64-5717-4562-b3fc-2c963f66afa7",
                name: "영어영문학과"
            )
        ]
    }
}

protocol WeaveDropDownFetchable: Hashable {
    var id: String { get }
    var name: String { get }
}

struct WeaveDropDownPicker<Content: View>: View {
    
    @Binding var selectedItem: (any WeaveDropDownFetchable)?
    @State var showDropDown = false
    
    var content: () -> Content
    
    var dataSources: [any WeaveDropDownFetchable]
    let itemSize: CGFloat = 56
    
    init(
        selectedItem: Binding<(any WeaveDropDownFetchable)?>,
        dataSources: [any WeaveDropDownFetchable],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selectedItem = selectedItem
        self.dataSources = dataSources
        self.content = content
    }
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(DesignSystem.Colors.darkGray)
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(0 ..< dataSources.count, id: \.self) { index in
                                let item = dataSources[index]
                                
                                if index != 0 {
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundStyle(DesignSystem.Colors.lightGray)
                                        .padding(.horizontal, 1)
                                }
                                
                                Button(action: {
                                    withAnimation {
                                        selectedItem = item
                                        showDropDown.toggle()
                                    }
                                }, label: {
                                    HStack(spacing: 16) {
                                        Image(systemName: "house")
                                        Text(item.name)
                                            .font(.pretendard(._500, size: 18))
                                        Spacer()
                                    }
                                    .foregroundStyle(DesignSystem.Colors.white)
                                    .frame(height: itemSize)
                                    .padding(.horizontal, 16)
                                    .background(DesignSystem.Colors.darkGray)
                                })
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 1)
                        .stroke(DesignSystem.Colors.lightGray, lineWidth: showDropDown ? 1 : 0)
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)

                )
                .frame(height: showDropDown ? itemSize * 3 : 50)
                .offset(y: showDropDown ? 125 : 0)
                
                content()
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.3)) {
                            showDropDown.toggle()
                        }
                    }
            }
            .frame(height: 50)
        }
    }
}
