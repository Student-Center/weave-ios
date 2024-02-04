//
//  ServerType.swift
//  Core
//
//  Created by 강동영 on 1/19/24.
//

import Foundation

enum ServerType {
    case develop // db 개발, api 개발
    case release // db 상용, api 상용
    
    var url: String {
        switch self {
        case .develop:
            return "http://43.200.117.125:8080/"
        case .release:
            return "www.apple.com"
        }
    }
}
