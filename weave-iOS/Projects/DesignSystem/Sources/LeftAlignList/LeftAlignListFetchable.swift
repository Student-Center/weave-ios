//
//  LeftAlignListFetchable.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/25/24.
//

import Foundation

public protocol LeftAlignListFetchable: Hashable, Equatable {
    var id: String { get } // 예를 들어 UUID를 사용
    var text: String { get }
}

