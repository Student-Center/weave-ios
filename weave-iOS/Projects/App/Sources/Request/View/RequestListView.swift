//
//  RequestListView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/11/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct RequestListView: View {
    @State var selection: Int = 0
    private let items: [String] = ["받은 요청", "보낸 요청"]
    let store: StoreOf<RequestListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                SegmentedPicker(items: self.items, selection: self.$selection)
                    .frame(width: 210)
                TabView(selection: $selection) {
                    if !viewStore.receivedDataSources.isEmpty {
                        getMeetingListView(
                            dataSources: viewStore.receivedDataSources,
                            type: .requesting
                        ) { meetingId in
                            print(meetingId)
                        }
                        .tag(0)
                        .onAppear {
                            viewStore.send(.onAppear(type: .requesting))
                        }
                    } else {
                        getEmptyView()
                            .tag(0)
                            .onAppear {
                                viewStore.send(.onAppear(type: .requesting))
                            }
                    }
                    
                    if !viewStore.sentDataSources.isEmpty {
                        getMeetingListView(
                            dataSources: viewStore.sentDataSources,
                            type: .requesting
                        ) { meetingId in
                            print(meetingId)
                        }
                        .tag(1)
                        .onAppear {
                            viewStore.send(.onAppear(type: .requesting))
                        }
                    } else {
                        getEmptyView()
                            .tag(1)
                            .onAppear {
                                viewStore.send(.onAppear(type: .requesting))
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
    
    @ViewBuilder
    func getMeetingListView(
        dataSources: [RequestMeetingItemModel],
        type: RequestListType,
        handler: @escaping (String) -> Void
    ) -> some View {
        VStack {
            ScrollView {
                ForEach(dataSources, id: \.id) { meeting in
                    MeetingItemView(meeting: meeting, type: type)
                        .onTapGesture {
                            handler(meeting.id)
                        }
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func getEmptyView() -> some View {
        VStack(alignment: .center, spacing: 10) {
            Text("미팅을 요청해 보세요!")
                .font(.pretendard(._600, size: 22))
            Text("아직 받은 요청이 없어요")
                .font(.pretendard(._500, size: 14))
                .foregroundStyle(DesignSystem.Colors.gray600)
            Spacer()
                .frame(height: 20)
            WeaveButton(title: "미팅 상대 둘러보기", size: .large) {
                //                handler()
            }
            .padding(.horizontal, 80)
        }
    }
}

fileprivate struct MeetingItemView: View {
    let meeting: RequestMeetingItemModel
    let type: RequestListType
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                RoundCornerBoxedTextView(
                    meeting.receivingTeam.teamIntroduce,
                    tintColor: DesignSystem.Colors.lightGray
                )
                Spacer()
                Text(meeting.getTimeDiffString(suffix: type.timeDiffSuffixValue))
                    .font(.pretendard(._500, size: 12))
                    .foregroundStyle(DesignSystem.Colors.defaultBlue)
            }
            
            HStack(alignment: .top) {
                Spacer()
                
                ForEach(meeting.receivingTeam.memberInfos, id: \.id) { member in
                    MemberIconView(
                        title: member.memberInfoValue,
                        subTitle: member.mbti ?? ""
                    )
                }
                Spacer()
            }
        }
        .weaveBoxStyle()
    }
}

fileprivate struct MemberIconView: View {
    let title: String
    let subTitle: String
    
    fileprivate var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 1)
//                    .stroke(.white, lineWidth: isLeader ? 1 : 0)
                    .background(DesignSystem.Colors.lightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .frame(width: 48, height: 48)
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 4) {
                Text(title)
                Text(subTitle)
            }
            .font(.pretendard(._600, size: 12))
        }
    }
}

#Preview {
    AppTabView(store: .init(initialState: AppTabViewFeature.State(selection: .request), reducer: {
        AppTabViewFeature(rootview: .constant(.mainView))
    }))
}
