//
//  Font+Ext.swift
//  DesignSystem
//
//  Created by Jisu Kim on 1/14/24.
//

import SwiftUI
import UIKit

public extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}
