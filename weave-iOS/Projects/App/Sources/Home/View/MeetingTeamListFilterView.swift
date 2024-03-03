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
    
    @State var locationFilterType: (any LeftAlignListFetchable)?
    @State var selectedLocation: (any LeftAlignListFetchable)?
    @State var selectedMeetingCount: (any LeftAlignListFetchable)?
    
    var listViewWidth: CGFloat {
        return UIScreen.main.bounds.width - 36
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                CenterTitleView(title: "필터 설정") {
                    viewStore.send(.dismiss)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("내가 찾는 미팅")
                            .font(.pretendard(._500, size: 16))
                            .padding(.vertical, 16)
                        
                        HStack {
                            LeftAlignTextCapsuleListView(
                                selectedItem: $selectedMeetingCount,
                                dataSources: MeetingMemberCountType.allCases,
                                viewWidth: listViewWidth
                            )
                            Spacer()
                        }
                        
                        getSectionDivider()
                            .padding(.vertical, 16)
                        
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
                            .padding(.vertical, 16)
                        
                        Text("선호 미팅 지역")
                            .font(.pretendard(._500, size: 16))
                            .padding(.vertical, 16)
                        
                        LeftAlignTextCapsuleListView(
                            selectedItem: $locationFilterType,
                            dataSources: MeetingLocationFilterType.allCases,
                            viewWidth: listViewWidth
                        )
                        
                        LeftAlignTextCapsuleListView(
                            selectedItem: $selectedLocation,
                            dataSources: filterData(list: viewStore.locationList, filterType: locationFilterType),
                            viewWidth: listViewWidth
                        )
                        .frame(maxHeight: .infinity)
                        
                        Spacer()
                            .frame(height: 20)
                    }
                    .padding(.vertical, 20)
                    
                }
                .padding(.horizontal, 16)
                .scrollIndicators(.hidden)
                
                WeaveButton(
                    title: "저장하기",
                    size: .large
                )
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
    
    func filterData(
        list: [MeetingLocationModel],
        filterType: (any LeftAlignListFetchable)?
    ) -> [any LeftAlignListFetchable] {
        guard let filterType,
              let type = filterType as? MeetingLocationFilterType else { return [] }
        switch type {
        case .capital:
            return list.filter { $0.isCapitalArea == true }
        case .nonCapital:
            return list.filter { $0.isCapitalArea == false }
        }
    }
}

#Preview {
    MeetingTeamListFilterView(store: Store(initialState: MeetingTeamListFilterFeature.State(), reducer: {
        MeetingTeamListFilterFeature()
    }))
}
