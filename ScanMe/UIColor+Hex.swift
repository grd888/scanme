//
//  UIColor+Hex.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        guard hex.count == 6 else {
            return nil
        }
        let redIndex = hex.index(hex.startIndex, offsetBy: 2)
        let red = hex.prefix(upTo: redIndex)

        let greenStart = hex.index(hex.startIndex, offsetBy: 2)
        let greenEnd = hex.index(hex.endIndex, offsetBy: -2)
        let greenRange = greenStart..<greenEnd
        let green = hex[greenRange]

        let blue = hex.suffix(2)
        
        guard let redValue = Int(red, radix: 16),
              let greenValue = Int(green, radix: 16),
              let blueValue = Int(blue, radix: 16) else {
                  return nil
              }
        
        self.init(red: CGFloat(redValue) / 255.0,
                       green: CGFloat(greenValue)/255.0,
                       blue: CGFloat(blueValue)/255.0,
                       alpha: 1.0)
    }
}
