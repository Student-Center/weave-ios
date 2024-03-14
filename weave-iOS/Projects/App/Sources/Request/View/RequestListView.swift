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
                    ReceivedMeetingListView(store: store)
                        .tag(0)
                        .onAppear {
                            viewStore.send(.onAppear(type: .receiving))
                        }
                    SentMeetingListView(store: store)
                        .tag(1)
                        .onAppear {
                            viewStore.send(.onAppear(type: .requesting))
                        }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
    
    @ViewBuilder
    func getEmptyView() -> some View {
        VStack(spacing: 10) {
            Text("🙏")
            Text("조금만 기다려 주세요")
                .font(.pretendard(._600, size: 22))
            Text("채팅 기능을 포함한 버전이\n곧 업데이트 될 예정이에요!")
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

fileprivate struct ReceivedMeetingListView: View {
    let store: StoreOf<RequestListFeature>
    
    fileprivate var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                HStack {
                    RoundCornerBoxedTextView(
                        "제목최대10글자일듯",
                        tintColor: DesignSystem.Colors.lightGray
                    )
                    Spacer()
                    Text("5시간 뒤에 사라져요!")
                        .font(.pretendard(._500, size: 12))
                        .foregroundStyle(DesignSystem.Colors.defaultBlue)
                }
                
                HStack(alignment: .top) {
                    Spacer()
                    MemberIconView(
                        title: "위브대•05",
                        subTitle: "ENTP"
                    )
                    MemberIconView(
                        title: "위브대•05",
                        subTitle: "ENTP"
                    )
                    MemberIconView(
                        title: "위브대•05",
                        subTitle: "ENTP"
                    )
                    Spacer()
                }
            }
            .weaveBoxStyle()
        }
    }
}

fileprivate struct SentMeetingListView: View {
    let store: StoreOf<RequestListFeature>
    
    fileprivate var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                HStack {
                    RoundCornerBoxedTextView(
                        "제목최대10글자일듯",
                        tintColor: DesignSystem.Colors.lightGray
                    )
                    Spacer()
                    Text("5시간 뒤에 사라져요!")
                        .font(.pretendard(._500, size: 12))
                        .foregroundStyle(DesignSystem.Colors.defaultBlue)
                }
                
                HStack(alignment: .top) {
                    Spacer()
                    MemberIconView(
                        title: "위브대•05",
                        subTitle: "ENTP"
                    )
                    MemberIconView(
                        title: "위브대•05",
                        subTitle: "ENTP"
                    )
                    MemberIconView(
                        title: "위브대•05",
                        subTitle: "ENTP"
                    )
                    Spacer()
                }
            }
            .weaveBoxStyle()
        }
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
    RequestListView(store: Store(initialState: RequestListFeature.State(), reducer: {
        RequestListFeature()
    }))
}
