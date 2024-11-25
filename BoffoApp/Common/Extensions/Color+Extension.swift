//
//  Color+Extension.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit
import SwiftUI

class AppColor{
    static let primaryTop = Color(UIColor(hex: "487BE3"))
    static let primaryBottom = Color(UIColor(hex: "2633C2"))
    static let primaryGreen = Color(UIColor(hex: "6ADA75"))
    static let primaryGreenDark = Color(UIColor(hex: "67C76A"))
    static let primaryYellow = Color(UIColor(hex: "e8da24"))
    static let btnPrimaryTop = Color(UIColor(hex: "487BE3"))
    static let btnPrimaryBottom = Color(UIColor(hex: "2633C2"))
    static let white = Color(UIColor(hex: "ffffff"))
    static let red = Color(UIColor(hex: "E0181E"))
    static let black = Color(UIColor(hex: "000000"))
    static let backGray = Color(UIColor(hex: "EEEEEE"))
    static let darkGray = Color(UIColor(hex: "8C8C8C"))
    static let lineGray = Color(UIColor(hex: "D1D1D1"))
    static let titleGray = Color(UIColor(hex: "515151"))
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
