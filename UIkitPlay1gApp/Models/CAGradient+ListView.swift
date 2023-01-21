//
//  CAGradient+ListView.swift
//  UIkitPlay1gApp
//
//  Created by Sergei Fonov on 19.01.23.
//

import UIKit

extension CAGradientLayer {
  static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
    let layer = Self()
    layer.colors = colors(for: style)
    layer.frame = frame
    return layer
  }

  private static func colors(for style: ReminderListStyle) -> [CGColor] {
    let beginColor: UIColor
    let endColor: UIColor

    switch style {
    case .today:
      beginColor = UIColor.brown
      endColor = UIColor.systemGray
    case .future:
      beginColor = UIColor.tintColor
      endColor = UIColor.systemGray
    case .all:
      beginColor = UIColor.cyan
      endColor = UIColor.systemGray
    }

    return [beginColor.cgColor, endColor.cgColor]
  }
}
