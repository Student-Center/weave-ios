//
//  LeftAlignTextCapsuleListView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/25/24.
//

import SwiftUI

public struct LeftAlignTextCapsuleListView: View {

    @Binding var selectedItem: (any LeftAlignListFetchable)?
    let dataSources: [any LeftAlignListFetchable]
    let viewWidth: CGFloat
    let backgroundColor: Color
    
    public init(
        selectedItem: Binding<(any LeftAlignListFetchable)?>,
        dataSources: [any LeftAlignListFetchable],
        viewWidth: CGFloat,
        backgroundColor: Color = .clear
    ) {
        self._selectedItem = selectedItem
        self.dataSources = dataSources
        self.viewWidth = viewWidth
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        ZStack(alignment: .topLeading) {
            ForEach(dataSources, id: \.id) { item in
                LeftAlignTextCapsuleItemView(
                    item: item,
                    isSelected: item.id == selectedItem?.id,
                    backgroundColor: backgroundColor
                )
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > viewWidth)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if item.id == self.dataSources.last!.id {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if item.id == self.dataSources.last!.id {
                        height = 0 // last item
                    }
                    return result
                })
                .onTapGesture {
                    selectedItem = item
                }
            }
        }
    }
}

fileprivate struct LeftAlignTextCapsuleItemView: View {
    let item: any LeftAlignListFetchable
    let isSelected: Bool
    let backgroundColor: Color
    
    var tintColor: Color {
        isSelected ? DesignSystem.Colors.defaultBlue : DesignSystem.Colors.lightGray
    }
    
    fileprivate var body: some View {
        CapsuleContentView(title: item.text, tintColor: tintColor, backgroundColor: backgroundColor)
    }
}

public struct CapsuleContentView: View {
    
    let title: String
    let tintColor: Color
    let backgroundColor: Color
    
    public init(title: String, tintColor: Color, backgroundColor: Color = .clear) {
        self.title = title
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        Text(title)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .font(.pretendard(._500, size: 15))
            .foregroundStyle(tintColor)
            .frame(height: 32)
            .background(backgroundColor)
            .overlay(
                Capsule()
                    .inset(by: 1)
                    .stroke(tintColor, lineWidth: 1)
                    .foregroundStyle(.clear)
            )
            .clipShape(Capsule())
    }
}
