//
//  UIFont+Extension.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//


import UIKit

extension UIFont {
  
  public enum InterFont: String {
    case regular = "-Regular"
    case medium = "-Medium"
    case bold = "-Bold"
    case semibold = "-SemiBold"
    case extrabold = "-ExtraBold"
  }
  
  static func Inter(_ type: InterFont = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
    return UIFont(name: "Inter\(type.rawValue)", size: size)!
  }
  
  var isBold: Bool {
    return fontDescriptor.symbolicTraits.contains(.traitBold)
  }
  
  var isItalic: Bool {
    return fontDescriptor.symbolicTraits.contains(.traitItalic)
  }
}
