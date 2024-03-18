//
//  String+Ext.swift
//  CoreKit
//
//  Created by Jisu Kim on 3/19/24.
//

import Foundation

public extension String {
    func toShortUnivName() -> String {
        return self.replacingOccurrences(of: "대학교", with: "대")
    }
}
