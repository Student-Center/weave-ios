//
//  RegisterUserRequestDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/10/24.
//

import Foundation
import Services

struct RegisterUserRequestDTO: Encodable {
    let gender: String
    let birthYear: Int
    let mbti: String
    let universityId: String
    let majorId: String
}

extension APIEndpoints {
    static func registerUser(registerToken: String, body: RegisterUserRequestDTO) -> EndPoint<TempTokenResponseDTO> {
        return EndPoint(
            baseURL: "http://43.200.117.125:8080/",
            path: "api/users",
            method: .post,
            bodyParameters: body,
            headers: ["Register-Token": registerToken]
        )
    }
}
