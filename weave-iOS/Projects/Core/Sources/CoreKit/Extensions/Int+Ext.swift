//
//  Int+Ext.swift
//  CoreKit
//
//  Created by Jisu Kim on 3/19/24.
//

import Foundation

public extension Int {
    func toShortBirthYear() -> String {
        let birthYear = String(self)
        guard birthYear.count > 2 else { return "N/A" }
        return String(birthYear.suffix(2))
    }
}
