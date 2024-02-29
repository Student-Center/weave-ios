//
//  MBTIDataModel.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/26/24.
//

import SwiftUI

public struct MBTIDataModel: Equatable {
    public static func == (lhs: MBTIDataModel, rhs: MBTIDataModel) -> Bool {
        return lhs.requestValue == rhs.requestValue
    }
    
    public enum MBTITypes: String {
        case E
        case e
        case I
        case i
        case N
        case n
        case S
        case s
        case F
        case f
        case T
        case t
        case P
        case p
        case J
        case j
        case none
    }
    
    public var 외향내향: MBTITypes
    public var 감각직관: MBTITypes
    public var 사고감정: MBTITypes
    public var 판단인식: MBTITypes
    
    public init(
        외향내향: MBTITypes = .none,
        감각직관: MBTITypes = .none,
        사고감정: MBTITypes = .none,
        판단인식: MBTITypes = .none
    ) {
        self.외향내향 = 외향내향
        self.감각직관 = 감각직관
        self.사고감정 = 사고감정
        self.판단인식 = 판단인식
    }
    
    public init(mbti: String) {
        self.init()
        guard mbti.count == 4 else {
            return
        }
        
        let characters = Array(mbti)
        self.외향내향 = MBTITypes(rawValue: String(characters[0])) ?? .none
        self.감각직관 = MBTITypes(rawValue: String(characters[1])) ?? .none
        self.사고감정 = MBTITypes(rawValue: String(characters[2])) ?? .none
        self.판단인식 = MBTITypes(rawValue: String(characters[3])) ?? .none
    }

    public var requestValue: String {
        return [외향내향, 감각직관, 사고감정, 판단인식]
            .map { $0.rawValue }
            .joined()
    }
    
    public func validate() -> Bool {
        return [외향내향, 감각직관, 사고감정, 판단인식].allSatisfy { $0 != .none }
    }
}
