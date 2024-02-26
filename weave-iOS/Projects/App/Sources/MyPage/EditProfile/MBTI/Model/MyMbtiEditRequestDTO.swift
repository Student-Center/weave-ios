//
//  MyMbtiEditRequestDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/26/24.
//

import Foundation
import Services

struct MyMbtiEditRequestDTO: Encodable {
    let mbti: String
}

extension APIEndpoints {
    static func editMyMbti(body: MyMbtiEditRequestDTO) -> EndPoint<TempTokenResponseDTO> {
        return EndPoint(
            path: "api/users/my/mbti",
            method: .patch,
            bodyParameters: body,
            headers: ["Auhtorization": "Bearer \(UDManager.accessToken)"]
        )
    }
}
