//
//  WeaveDropDown.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/10/24.
//

import SwiftUI

public protocol WeaveDropDownFetchable: Hashable, Equatable {
    var id: String { get }
    var name: String { get }
    var iconAssetName: String? { get }
}

public struct WeaveDropDownPicker<Content: View>: View {
    
    @FocusState var showDropDown: Bool
    
    var tapHandler: ((Int) -> Void)?
    var content: () -> Content
    
    var dataSources: [any WeaveDropDownFetchable]
    let itemSize: CGFloat = 56
    
    var frameHeight: CGFloat {
        if !showDropDown {
            return 50
        }
        
        if dataSources.count > 2 {
            return itemSize * 3
        }
        
        return itemSize * CGFloat(dataSources.count)
    }
    
    var frameOffset: CGFloat {
        if !showDropDown {
            return 0
        }
        
        if dataSources.count > 2 {
            return 125
        }
        
        return 125 - 28 * CGFloat(3 - dataSources.count)
    }
    
    public init(
        dataSources: [any WeaveDropDownFetchable],
        showDropDown: FocusState<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        tapHandler: ((Int) -> Void)? = nil
    ) {
        self.dataSources = dataSources
        self.content = content
        self.tapHandler = tapHandler
        self._showDropDown = showDropDown
    }
    
    public var body: some View {
        VStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(DesignSystem.Colors.darkGray)
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
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
                                        tapHandler?(index)
                                        showDropDown.toggle()
                                    }
                                }, label: {
                                    HStack(spacing: 16) {
                                        if let iconName = item.iconAssetName {
                                            ImageAsset(name: iconName).image
                                        }
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
                .frame(height: frameHeight)
                .offset(y: frameOffset)
                
                content()
            }
            .frame(height: 50)
        }
    }
}
