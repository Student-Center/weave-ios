//
//  EndPoint.swift
//  Core
//
//  Created by 강동영 on 1/19/24.
//

import Foundation

public protocol RequestResponsable: Requestable, Responsable {}

public class EndPoint<R>: RequestResponsable {
    public typealias Response = R
  
    public var baseURL: String = APIProvider.serverType.baseURL
    public var path: String
    public var method: HTTPMethod
    public var queryParameters: Encodable?
    public var bodyParameters: Encodable?
    public var headers: [String : String]?
    
    public init(path: String,
         method: HTTPMethod,
         queryParameters: Encodable? = nil,
         bodyParameters: Encodable? = nil,
         headers: [String : String]? = nil) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
    
    public init(baseURL: String,
         path: String,
         method: HTTPMethod,
         queryParameters: Encodable? = nil,
         bodyParameters: Encodable? = nil,
         headers: [String : String]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
