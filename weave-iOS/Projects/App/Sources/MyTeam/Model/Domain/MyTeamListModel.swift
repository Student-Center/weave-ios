//
//  MyTeamListModel.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/6/24.
//

import Foundation

struct MyTeamListModel {
    let items: [MyTeamResponseDTO]
    let next: String
    let total: Int
}

struct MyTeamItemModel: Identifiable, Equatable {
    static func == (lhs: MyTeamItemModel, rhs: MyTeamItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let teamIntroduce: String
    let memberCount: MeetingMemberCountType?
    let location: String
    let memberInfos: [MyTeamMemberModel]
    
    init(
        id: String,
        teamIntroduce: String,
        memberCount: Int,
        location: String,
        memberInfos: [MyTeamMemberModel]
    ) {
        self.id = id
        self.teamIntroduce = teamIntroduce
        self.memberCount = MeetingMemberCountType(rawValue: memberCount) 
        self.location = location
        self.memberInfos = memberInfos
    }
}

struct MyTeamMemberModel {
    let id: String
    let universityName: String
    let mbti: String
    let birthYear: Int
    let role: String
    let isMe: Bool
    
    init(
        id: String,
        universityName: String,
        mbti: String,
        birthYear: Int,
        role: String,
        isMe: Bool
    ) {
        self.id = id
        self.universityName = universityName
        self.mbti = mbti
        self.birthYear = birthYear
        self.role = role
        self.isMe = isMe
    }
}
