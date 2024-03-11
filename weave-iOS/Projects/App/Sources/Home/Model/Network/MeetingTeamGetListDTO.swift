//
//  MeetingTeamGetListDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/29/24.
//

import Foundation
import Services

struct MeetingTeamGetListDTO: Codable {
    let items: [MeetingTeamDTO]
    let next: String?
    let total: Int
    
    var toDomain: MeetingTeamListModel {
        return MeetingTeamListModel(
            items: items.map { MeetingTeamModel(
                id: $0.id,
                teamIntroduce: $0.teamIntroduce,
                memberCount: $0.memberCount,
                gender: $0.gender,
                location: $0.location,
                memberInfos: $0.memberInfos.map { memberDTO in
                    MeetingMemberModel(
                        id: memberDTO.id,
                        universityName: memberDTO.universityName,
                        mbti: memberDTO.mbti,
                        birthYear: memberDTO.birthYear,
                        animalType: memberDTO.animalType
                    )
                }
            )
            },
            next: next,
            total: total
        )
    }
}

// MARK: - Item
struct MeetingTeamDTO: Codable {
    let id: String
    let teamIntroduce: String
    let memberCount: Int
    let gender: String?
    let location: String
    let memberInfos: [MeetingMemberDTO]
}

// MARK: - MemberInfo
struct MeetingMemberDTO: Codable {
    let id: String
    let universityName: String
    let mbti: String
    let birthYear: Int
    let animalType: String?
}

extension APIEndpoints {
    static func getMeetingTeamList(requestDTO: MeetingTeamGetListRequestDTO) -> EndPoint<MeetingTeamGetListDTO> {
        return EndPoint(
            path: "api/meeting-teams",
            method: .get,
            queryParameters: requestDTO,
            headers: [
                "Authorization": "Bearer \(UDManager.accessToken)"
            ]
        )
    }
}
