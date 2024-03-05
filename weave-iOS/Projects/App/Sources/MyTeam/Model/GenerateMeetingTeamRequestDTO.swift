//
//  GenerateMeetingTeamRequestDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/6/24.
//

import Foundation
import Services

struct GenerateMeetingTeamRequestDTO: Encodable {
    let teamIntroduce: String
    let memberCount: Int
    let location: String
}

extension APIEndpoints {
    static func getGenerateMeetingTeam(requestDTO: GenerateMeetingTeamRequestDTO) -> EndPoint<MeetingTeamDetailResponseDTO> {
        return EndPoint(
            path: "api/meeting-teams",
            method: .post,
            bodyParameters: requestDTO,
            headers: [
                "Authorization": "Bearer \(SecretKey.token)"
            ]
        )
    }
}
