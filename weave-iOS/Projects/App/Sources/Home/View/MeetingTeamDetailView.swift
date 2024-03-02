//
//  MeetingTeamDetailView.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/1/24.
//

import SwiftUI
import DesignSystem

struct MeetingTeamDetailView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    getHeaderView()
                        .padding(.vertical, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("제목 최대 10글자인듯")
                            .font(.pretendard(._600, size: 16))
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    LocationIconView(region: "서울")
                }
            }
        }
    }
    
    @ViewBuilder
    func getHeaderView() -> some View {
        Text("이런게 환상의 케미?")
        
    }
}



#Preview {
    StarRatingView(rating: 3.5)
}
