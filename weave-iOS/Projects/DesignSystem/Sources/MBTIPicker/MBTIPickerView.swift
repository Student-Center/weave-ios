//
//  MBTIPickerView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/26/24.
//

import SwiftUI

public struct MBTIPickerView: View {
    
    @Binding var mbtiDataModel: MBTIDataModel
    
    public init(model: Binding<MBTIDataModel>) {
        self._mbtiDataModel = model
    }
    
    public var body: some View {
        VStack {
            HorizonCirclePicker(
                dataSources: [.E, .e, .i, .I],
                leadingText: "외향적",
                trailingText: "내향적",
                selectedData: $mbtiDataModel.외향내향
            )
            
            HorizonCirclePicker(
                dataSources: [.N, .n, .s, .S],
                leadingText: "직관적",
                trailingText: "현실적",
                selectedData: $mbtiDataModel.감각직관
            )
            
            HorizonCirclePicker(
                dataSources: [.F, .f, .t, .T],
                leadingText: "감성적",
                trailingText: "이성적",
                selectedData: $mbtiDataModel.사고감정
            )
            
            HorizonCirclePicker(
                dataSources: [.P, .p, .j, .J],
                leadingText: "즉흥적",
                trailingText: "계획적",
                selectedData: $mbtiDataModel.판단인식
            )
        }
    }
}

fileprivate struct HorizonCirclePicker: View {
        
    let dataSources: [MBTIDataModel.MBTITypes]
    let leadingText: String
    let trailingText: String
    @Binding var selectedData: MBTIDataModel.MBTITypes
    
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
                        
                        let mbti = dataSources[index]
                        let isSelected = mbti == selectedData
                        
                        let tintColor = isSelected ? DesignSystem.Colors.defaultBlue : DesignSystem.Colors.lightGray
                        
                        ZStack {
                            Circle()
                                .foregroundStyle(DesignSystem.Colors.darkGray)
                                .frame(width: size, height: size)
                            Text(mbti.rawValue)
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
                            selectedData = mbti
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
