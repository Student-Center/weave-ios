//
//  MeetingTeamListFilterView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/3/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct MeetingTeamListFilterView: View {
    let store: StoreOf<MeetingTeamListFilterFeature>
    
    @State var selectedLocation: (any LeftAlignListFetchable)?
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        CenterTitleView(title: "필터 설정") {
                            viewStore.send(.dismiss)
                        }
                        
                        Text("내가 찾는 미팅")
                            .font(.pretendard(._500, size: 16))
                            .padding(.vertical, 16)
                        
                        HStack {
                            CapsuleContentView(title: "2 : 2", tintColor: DesignSystem.Colors.lightGray)
                            CapsuleContentView(title: "3 : 3", tintColor: DesignSystem.Colors.lightGray)
                            CapsuleContentView(title: "4 : 4", tintColor: DesignSystem.Colors.lightGray)
                        }
                        .padding(.bottom, 16)
                        
                        getSectionDivider()
                        
                        HStack {
                            Text("미팅 상대 나이대")
                                .font(.pretendard(._500, size: 16))
                            Spacer()
                            Text("06년생 ~ 96년생")
                                .font(.pretendard(._500, size: 16))
                                .foregroundStyle(DesignSystem.Colors.defaultBlue)
                        }
                        .padding(.vertical, 16)
                        
                        Slider(value: .constant(0.5))
                            .padding(.bottom, 20)
                        
                        getSectionDivider()
                        
                        Text("선호 미팅 지역")
                            .font(.pretendard(._500, size: 16))
                            .padding(.vertical, 16)
                        
                        GeometryReader { geometry in
                            LeftAlignTextCapsuleListView(
                                selectedItem: $selectedLocation,
                                dataSources: viewStore.locationList,
                                geometry: geometry
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                WeaveButton(title: "저장하기", size: .large)
                    .padding(.horizontal, 16)
            }
            .background(DesignSystem.Colors.darkGray)
            .onAppear {
                viewStore.send(.requestMeetingLocationList)
            }
        }
    }
    
    @ViewBuilder
    func getSectionDivider() -> some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(DesignSystem.Colors.lightGray)
    }
}

#Preview {
    MeetingTeamListFilterView(store: Store(initialState: MeetingTeamListFilterFeature.State(), reducer: {
        MeetingTeamListFilterFeature()
    }))
}
