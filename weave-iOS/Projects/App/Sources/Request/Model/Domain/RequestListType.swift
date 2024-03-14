//
//  RequestListType.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/15/24.
//

import Foundation

enum RequestListType {
    case requesting
    case receiving
    
    var requestValue: String {
        switch self {
        case .requesting: return "REQUESTING"
        case .receiving: return "RECEIVING"
        }
    }
}
