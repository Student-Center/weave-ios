//
//  UniversityResponseDTO.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/10/24.
//

import Foundation
import Services

struct UniversitiesResponseDTO: Decodable {
    let universities: [UniversityResponseDTO]
}

struct UniversityResponseDTO: Decodable, Equatable {
    let id: String
    let name: String
    let domainAddress: String
    let logoAddress: String?
    
    var toDomain: UniversityModel {
        return UniversityModel(
            id: id,
            name: name,
            domainAddress: domainAddress,
            logoAddress: logoAddress,
            iconAssetName: "univ"
        )
    }
}

extension APIEndpoints {
    static func getUniversityInfo() -> EndPoint<UniversitiesResponseDTO> {
        return EndPoint(
            baseURL: "http://43.200.117.125:8080/",
            path: "api/univ",
            method: .get
        )
    }
}

/// Login Feature 머지전까지 사용할 임시 DTO
struct TempTokenResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
