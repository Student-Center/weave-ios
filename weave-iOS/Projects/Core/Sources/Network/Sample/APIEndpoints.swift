//
//  APIEndpoints.swift
//  Services
//
//  Created by 강동영 on 2/4/24.
//

import Foundation

public struct UniversitiesResponseDTO: Decodable {
    let universities: [UniversityResponseDTO]
}

struct UniversityResponseDTO: Decodable {
    let id: String
    let name: String
    let domainAddress: String
    let logoAddress: String
}

public struct APIEndpoints {
    static func getUniversitiesInfo() -> EndPoint<UniversitiesResponseDTO> {
        return EndPoint(baseURL: "http://43.200.117.125:8080/",
                        path: "api/univ",
                        method: .get)
    }
}
