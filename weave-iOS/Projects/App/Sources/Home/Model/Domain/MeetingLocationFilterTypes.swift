//
//  MeetingLocationFilterTypes.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/3/24.
//

import DesignSystem
import Foundation

enum MeetingLocationFilterType: String, CaseIterable, LeftAlignListFetchable {
    case capital
    case nonCapital
    
    var id: String {
        return self.rawValue
    }
    
    var text: String {
        switch self {
        case .capital: return "수도권"
        case .nonCapital: return "비수도권"
        }
    }
}

enum MeetingMemberCountType: String, CaseIterable, LeftAlignListFetchable {
    case two
    case three
    case four
    
    var id: String {
        return self.rawValue
    }
    
    var text: String {
        switch self {
        case .two: return "2 : 2"
        case .three: return "3 : 3"
        case .four: return "4 : 4"
        }
    }
}
