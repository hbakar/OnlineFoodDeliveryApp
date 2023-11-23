//
//  UIFont+Extension.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import UIKit

extension UIFont {
    
    static var InterRegular: UIFont={
        let font = UIFont(name: "Inter-Regular", size: 14)!
        return font
    }()
    
    static var InterMedium: UIFont = {
        let font = UIFont(name: "Inter-Medium", size: 14)!
        return font
    }()
    
    static var InterSemiBold: UIFont = {
        let font = UIFont(name: "Inter-SemiBold", size: 14)!
        return font
    }()
    
    static var InterBold: UIFont = {
        let font = UIFont(name: "Inter-Bold", size: 14)!
        return font
    }()
    
    static var InterExtraBold: UIFont = {
        let font = UIFont(name: "Inter-ExtraBold", size: 14)!
        return font
    }()
    
    static func customFont(name: String, size: CGFloat) -> UIFont {
          guard let customFont = UIFont(name: name, size: size) else {
              return UIFont.systemFont(ofSize: size)
          }
          return customFont
      }
}
