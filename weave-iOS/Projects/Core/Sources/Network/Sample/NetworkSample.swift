//
//  NetworkSample.swift
//  Core
//
//  Created by 강동영 on 1/20/24.
//

import SwiftUI

/*
 샘플코드 !
 
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            NetworkSample.requestSample { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

#Preview {
    ContentView()
}

public struct NetworkSample {
    static public func requestSample(completion: @escaping (Result<UniversitiesResponseDTO, Error>) -> Void) {
        let endPoint = APIEndpoints.getUniversitiesInfo()
        let provider = APIProvider(session: URLSession.shared)
        provider.request(with: endPoint) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

*/
