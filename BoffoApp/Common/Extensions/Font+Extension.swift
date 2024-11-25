//
//  Font+Extension.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

public extension Font {

    static func lato(_ size: CGFloat, weight: Lato) -> Font {
        Font.custom(weight.rawValue, size: size)
    }

    static func robotoMono(_ size: CGFloat, weight: RobotoMono) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}

public enum Lato: String {
    case regular = "Lato-Regular"
    case semibold = "Lato-Semibold"
    case bold = "Lato-Bold"
    case black = "Lato-Black"
}

public enum RobotoMono: String {
    case regular = "RobotoMono-Regular"
    case bold = "RobotoMono-Bold"
}
