//
//  EmailVerificationRequestDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/20/24.
//

import Foundation
import Services

struct SendVerificationRequestDTO: Encodable {
    let universityEmail: String
}

extension APIEndpoints {
    static func sendVerifyEmail(body: SendVerificationRequestDTO) -> EndPoint<Int> {
        return EndPoint(
            path: "api/users/my/university-verification:send",
            method: .post,
            bodyParameters: body
        )
    }
}
