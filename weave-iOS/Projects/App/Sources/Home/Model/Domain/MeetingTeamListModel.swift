//
//  MeetingRoomListModel.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/29/24.
//

import Foundation

struct MeetingTeamListModel: Equatable {
    let items: [MeetingTeamModel]
    let next: String?
    let total: Int
}

// MARK: - Item
struct MeetingTeamModel: Equatable, Hashable {
    let id: String
    let teamIntroduce: String
    let memberCount: Int
    let gender: String?
    let location: String
    let memberInfos: [MeetingMemberModel]
}

// MARK: - MemberInfo
struct MeetingMemberModel: Equatable, Hashable {
    let id: String
    let universityName: String
    let mbti: String
    let birthYear: Int
    let animalType: String?
    
    var userInfoString: String {
        // ToDo - 알맞게 패턴 처리
        return "\(universityName.toShortUnivName())・\(birthYear.toShortBirthYear())\n\(mbti)"
    }
}

//MARK: - Extension - 추후 Core 모듈로
extension Int {
    func toShortBirthYear() -> String {
        let birthYear = String(self)
        guard birthYear.count > 2 else { return "N/A" }
        return String(birthYear.suffix(2))
    }
}

extension String {
    func toShortUnivName() -> String {
        return self.replacingOccurrences(of: "대학교", with: "대")
    }
}
