//
//  UIColor+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/18.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

extension UIColor {
        
    static func from(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        let count = hexString.count
        if ![6, 8].contains(count) {
            return UIColor.gray
        }

        var hexInt: UInt64 = 0
        let scanner = Scanner(string: hexString)

        let redBits: UInt64 = count == 6 ? 0xff0000 : 0xff000000
        let blueBits: UInt64 = count == 6 ? 0x00ff00 : 0x00ff0000
        let greenBits: UInt64 = count == 6 ? 0x0000ff : 0x0000ff00
        let bitwiseDifference = count == 6 ? 8 : 0

        if scanner.scanHexInt64(&hexInt) {
            let red = CGFloat((hexInt & redBits) >> (24 - bitwiseDifference)) / 255
            let green = CGFloat((hexInt & blueBits) >> (16 - bitwiseDifference)) / 255
            let blue = CGFloat((hexInt & greenBits) >> (8 - bitwiseDifference)) / 255

            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }

        return UIColor.gray
    }
}
