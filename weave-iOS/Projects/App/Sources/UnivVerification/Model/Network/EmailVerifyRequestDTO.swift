//
//  EmailVerifyRequestDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/21/24.
//

import Foundation
import Services

struct EmailVerifyRequestDTO: Encodable {
    let universityEmail: String
    let verificationNumber: String
}

extension APIEndpoints {
    static func verifyCode(body: EmailVerifyRequestDTO) -> EndPoint<Int> {
        return EndPoint(
            path: "api/users/my/university-verification:verify",
            method: .post,
            bodyParameters: body
        )
    }
}
