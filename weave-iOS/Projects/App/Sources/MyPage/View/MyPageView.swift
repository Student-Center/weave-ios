//
//  MyPageView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/15/24.
//

import SwiftUI
import DesignSystem

struct MyPageView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    MyProfileHeaderSectionView()
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    
                    VStack(spacing: 0) {
                        ForEach(MyPageCategoryTypes.allCases, id: \.self) { category in
                            MyPageSubViewHeaderView(headerTitle: category.headerTitle)
                            ForEach(0 ..< category.getSubViewModels().count, id: \.self) { index in
                                let item = category.getSubViewModels()[index]
                                MyPageSubSectionView(
                                    index: index,
                                    item: item
                                )
                            }
                            Spacer()
                                .frame(height: 12)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("마이")
                        .font(.pretendard(._600, size: 20))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        DesignSystem.Icons.setting
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                    .foregroundStyle(.white)
                }
            })
        }
    }
}

fileprivate struct MyProfileHeaderSectionView: View {
    fileprivate var body: some View {
        VStack(spacing: 20) {
            HStack {
                DesignSystem.Icons.profileImage
                    .resizable()
                    .frame(width: 80, height: 80)
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 3) {
                        Text("위브대학교")
                        DesignSystem.Icons.certified
                            .resizable()
                            .frame(width: 14, height: 14)
                    }
                    Text("위브만세학과")
                    Text("05년생")
                }
                .font(.pretendard(._500, size: 14))
                
                Spacer()
                
                VStack {
                    HStack(spacing: 3) {
                        Text("보유")
                            .font(.pretendard(._700, size: 10))
                        Text("0실")
                            .font(.pretendard(._700, size: 12))
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 10)
                    .frame(height: 28)
                    .background(LinearGradient.weaveGradientReversed)
                    .clipShape(
                        Capsule()
                    )
                    Spacer()
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(DesignSystem.Colors.darkGray)
                Text("⚠️ 프로필 사진은 미팅 매칭 후 생성된 채팅방에서만 확인 가능하니 안심하세요!")
                    .font(.pretendard(._400, size: 11))
            }
            .frame(height: 24)
        }
    }
}

fileprivate struct MyPageSubViewHeaderView: View {
    
    let headerTitle: String
    
    fileprivate var body: some View {
        HStack {
            Text(headerTitle)
                .font(.pretendard(._600, size: 14))
                .foregroundStyle(DesignSystem.Colors.textGray)
            Spacer()
        }
        .frame(height: 54)
    }
}

fileprivate struct MyPageSubSectionView: View {
    let index: Int
    let item: MyPageSubViewItemModel
    
    fileprivate var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(DesignSystem.Colors.darkGray)
                Spacer()
            }
            HStack {
                item.icon
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(item.title)
                    .font(.pretendard(._500, size: 16))
                Spacer()
                Text(item.actionTitle)
                    .font(.pretendard(._500, size: 14))
                    .foregroundStyle(DesignSystem.Colors.defaultBlue)
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
                    .foregroundStyle(DesignSystem.Colors.textGray)
            }
        }
        .frame(height: 54)
    }
}

#Preview {
    MyPageView()
}
