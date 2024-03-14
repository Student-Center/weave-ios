//
//  RequestMeetingListResponseDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/15/24.
//

import Foundation
import Services
import DesignSystem

struct RequestMeetingListResponseDTO: Codable {
    let items: [RequestMeetingItemResponseDTO]
    let next: String?
    let total: Int?
    
    var toDomain: RequestMeetingListModel {
        return RequestMeetingListModel(
            items: items.map { $0.toDomain },
            next: next,
            total: total
        )
    }
}

struct RequestMeetingItemResponseDTO: Codable {
    let id: String
    let requestingTeam: RequestMeetingTeamInfoResponseDTO
    let receivingTeam: RequestMeetingTeamInfoResponseDTO
    let teamType: String
    let status: String
    let createdAt: String
    let pendingEndAt: String
    
    var toDomain: RequestMeetingItemModel {
        RequestMeetingItemModel(
            id: id,
            requestingTeam: requestingTeam.toDomain,
            receivingTeam: receivingTeam.toDomain,
            teamType: teamType,
            status: status,
            createdAt: createdAt,
            pendingEndAt: pendingEndAt
        )
    }
}

struct RequestMeetingTeamInfoResponseDTO: Codable {
    let id: String
    let teamIntroduce: String
    let memberCount: Int
    let gender: String
    let memberInfos: [RequestMeetingMemberInfoResponseDTO]
    
    var toDomain: RequestMeetingTeamInfoModel {
        return RequestMeetingTeamInfoModel(
            id: id,
            teamIntroduce: teamIntroduce,
            memberCount: memberCount,
            gender: gender,
            memberInfos: memberInfos.map { $0.toDomain }
        )
    }
}

struct RequestMeetingMemberInfoResponseDTO: Codable {
    let id: String
    let userId: String
    let universityName: String
    let mbti: String?
    let birthYear: Int
    let animalType: String?
    
    var toDomain: RequestMeetingMemberInfoModel {
        return RequestMeetingMemberInfoModel(
            id: id,
            userId: userId,
            universityName: universityName,
            mbti: MBTIType(rawValue: mbti ?? ""),
            birthYear: birthYear,
            animalType: AnimalTypes(rawValue: animalType ?? "")
        )
    }
}

struct RequestMeetingListRequestDTO: Codable {
    let teamType: String
    let next: String?
    let limit: Int
    
    init(
        teamType: RequestListType,
        next: String? = nil,
        limit: Int = 10
    ) {
        self.teamType = teamType.requestValue
        self.next = next
        self.limit = limit
    }
}

//MARK: - Domain
struct RequestMeetingListModel: Equatable {
    let items: [RequestMeetingItemModel]
    let next: String?
    let total: Int?
}

struct RequestMeetingItemModel: Equatable {
    static func == (lhs: RequestMeetingItemModel, rhs: RequestMeetingItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let requestingTeam: RequestMeetingTeamInfoModel
    let receivingTeam: RequestMeetingTeamInfoModel
    let teamType: String
    let status: String
    let createdAt: String
    let pendingEndAt: String
}

struct RequestMeetingTeamInfoModel {
    let id: String
    let teamIntroduce: String
    let memberCount: Int
    let gender: String
    let memberInfos: [RequestMeetingMemberInfoModel]
}

struct RequestMeetingMemberInfoModel {
    let id: String
    let userId: String
    let universityName: String
    let mbti: MBTIType?
    let birthYear: Int
    let animalType: AnimalTypes?
}

extension APIEndpoints {
    static func getRequestMeetingTeamList(
        request: RequestMeetingListRequestDTO,
        nextId: String? = nil
    ) -> EndPoint<RequestMeetingListResponseDTO> {
        return EndPoint(
            path: "api/meetings/status/pending",
            method: .get,
            queryParameters: request,
            headers: [
                "Authorization": "Bearer \(UDManager.accessToken)"
            ]
        )
    }
}
