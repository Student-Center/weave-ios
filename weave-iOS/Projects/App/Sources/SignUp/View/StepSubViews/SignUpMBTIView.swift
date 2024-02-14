//
//  SignUpMBTIView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/4/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SignUpMBTIView: View {
    
    let store: StoreOf<SignUpFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HorizonCirclePicker(
                    selectedData: viewStore.$mbtiDatas.EorI,
                    dataSources: ["E", "e", "i", "I"],
                    leadingText: "외향적",
                    trailingText: "내향적"
                )
                
                HorizonCirclePicker(
                    selectedData: viewStore.$mbtiDatas.NorS,
                    dataSources: ["N", "n", "s", "S"],
                    leadingText: "직관적",
                    trailingText: "현실적"
                )
                
                HorizonCirclePicker(
                    selectedData: viewStore.$mbtiDatas.ForT,
                    dataSources: ["F", "f", "t", "T"],
                    leadingText: "감성적",
                    trailingText: "이성적"
                )
                
                HorizonCirclePicker(
                    selectedData: viewStore.$mbtiDatas.PorJ,
                    dataSources: ["P", "p", "j", "J"],
                    leadingText: "즉흥적",
                    trailingText: "계획적"
                )
                
                Spacer()
                
                WeaveButton(
                    title: "다음으로",
                    size: .medium,
                    isEnabled: viewStore.mbtiDatas.validate()
                ) {
                    viewStore.send(
                        .didTappedNextButton,
                        animation: .easeInOut(duration: 0.2)
                    )
                }
                .padding(.bottom, 20)
            }
        }
    }
}

fileprivate struct HorizonCirclePicker: View {
    
    @Binding var selectedData: String?
    
    let dataSources: [String]
    let leadingText: String
    let trailingText: String
    
    fileprivate var body: some View {
        VStack(spacing: 11) {
            ZStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(DesignSystem.Colors.lightGray)
                HStack {
                    ForEach(0 ..< dataSources.count, id: \.self) { index in
                        
                        // 큰 사이즈 조건
                        let needLargeSize = (index == 0) || (index == dataSources.count - 1)
                        let size: CGFloat = needLargeSize ? 53 : 37
                        
                        let data = dataSources[index]
                        let isSelected = data == selectedData
                        
                        let tintColor = isSelected ? DesignSystem.Colors.defaultBlue : DesignSystem.Colors.lightGray
                        
                        ZStack {
                            Circle()
                                .foregroundStyle(DesignSystem.Colors.darkGray)
                                .frame(width: size, height: size)
                            Text(data)
                                .foregroundStyle(tintColor)
                                .font(.pretendard(._400, size: needLargeSize ? 28 : 20))
                        }
                        .overlay(
                            Circle()
                                .stroke(
                                    tintColor,
                                    lineWidth: 1
                                )
                                .foregroundStyle(.clear)
                        )
                        .onTapGesture {
                            selectedData = data
                        }
                        
                        // 마지막 Index 인 경우
                        if index != dataSources.count - 1 {
                            Spacer()
                        }
                    }
                }
            }
            
            HStack {
                Text(leadingText)
                Spacer()
                Text(trailingText)
            }
            .font(.pretendard(._500, size: 16))
            .padding(.horizontal, 5)
        }
        .padding(.vertical, 8)
    }
}
