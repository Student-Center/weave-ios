//
//  APIEndpoints.swift
//  Services
//
//  Created by 강동영 on 2/4/24.
//

import Foundation

/*
 !샘플코드!
public struct UniversitiesResponseDTO: Decodable {
    public let universities: [UniversityResponseDTO]
}

public struct UniversityResponseDTO: Decodable, Equatable {
    public let id: String
    public let name: String
    public let domainAddress: String
    public let logoAddress: String?
}
 */

public struct APIEndpoints {
    public static func sampleEndpoint() -> EndPoint<EmptyResponse> {
        return EndPoint(
            path: "api/univ",
            method: .get
        )
    }
}
