//
//  Color+Ext.swift
//  DesignSystem
//
//  Created by Jisu Kim on 1/14/24.
//
import SwiftUI
import UIKit

extension Color {
  public init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(
      red: Double(red) / 255.0,
      green: Double(green) / 255.0,
      blue: Double(blue) / 255.0
    )
  }

  public init(hex: Int) {
    self.init(
      red: (hex >> 16) & 0xFF,
      green: (hex >> 8) & 0xFF,
      blue: hex & 0xFF
    )
  }
}

// MARK: - Helpers

public extension Color {
  var uiColor: UIColor {
    UIColor(self)
  }
}
