//
//  MyAnimalSelectionView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/25/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct MyAnimalSelectionView: View {
    
    @State var selectedAnimal: (any LeftAlignListFetchable)?
    let store: StoreOf<MyAnimalSelectionFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ZStack {
                    Text("내가 닮은 동물상은?")
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
                .frame(height: 54)
                AnimalSelectionList(
                    selectedItem: $selectedAnimal
                )
                
                Spacer()
                
                WeaveButton(
                    title: "저장하기",
                    size: .large,
                    isEnabled: selectedAnimal != nil
                ) {
                    guard let selectedAnimal,
                          let animal = selectedAnimal as? AnimalTypes else {
                        return
                    }
                    viewStore.send(.didTappedSaveButton(animal: animal))
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct AnimalSelectionList: View {
    
    @Binding var selectedItem: (any LeftAlignListFetchable)?
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    LeftAlignTextCapsuleListView(
                        selectedItem: $selectedItem,
                        dataSources: AnimalTypes.allCases,
                        geometry: geometry
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    MyAnimalSelectionView(
        store: Store(initialState: MyAnimalSelectionFeature.State(), reducer: {
            MyAnimalSelectionFeature()
        })
    )
}
