//
//  MeetingMatchActionRequest.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/17/24.
//

import Foundation
import Services

extension APIEndpoints {
    static func getMeetingMatchAction(teamId: String, actionType: MeetingMatchFeature.MatchActionType) -> EndPoint<EmptyResponse> {
        return EndPoint(
            path: "api/meetings/\(teamId)/attendance:\(actionType.requestValue)",
            method: .post,
            headers: [
                "Authorization": "Bearer \(UDManager.accessToken)"
            ]
        )
    }
}
