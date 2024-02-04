//
//  Provider.swift
//  Core
//
//  Created by 강동영 on 1/19/24.
//

import Foundation

struct DummyAPI: Decodable {
    let name: String
}

class APIProvider {
    let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequestResponsable>(with endPoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R {
        
        do {
            let request = try endPoint.getUrlRequest()
            
            let task: URLSessionTask = session
                .dataTask(with: request) { data, urlResponse, error in
                    guard let response = urlResponse as? HTTPURLResponse,
                          (200...399).contains(response.statusCode) else {
                        completion(.failure(error as? NetworkError ?? NetworkError.unknownError))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NetworkError.emptyData))
                        return
                    }
                    
                    guard let response = try? JSONDecoder().decode(R.self, from: data) else {
                        completion(.failure(NetworkError.decodeError))
                        return
                    }
                    
                    completion(.success(response))
                }
            
            task.resume()
            
        } catch {
            completion(.failure(NetworkError.urlRequest(error)))
        }
    }
}
