//
//  BAFont.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

enum BAFont {
    /// 34, Bold, Lato
    case heading1
    /// 27, Bold, Lato
    case heading2
    /// 23, Bold, Lato
    case heading3
    /// 23, Bold, Lato
    case heading4

    /// 17, Regular, Lato
    case body1
    /// 17, Bold, Lato
    case body1Bold
    case body1Black
    /// 15, Regular, Lato
    case body2
    /// 17, Semibold, Lato
    case body1Semibold
    /// 15, Semibold, Lato
    case body2Semibold
    /// 15, Bold, Lato
    case body2Bold
    /// 13, Regular, Lato
    case body3

    /// 17, Black, Lato
    case label
    /// 10, Regular, Lato
    case detail
    /// 17, Regular, Roboto Mono
    case cardLabel
    /// 17, Bold, Roboto Mono
    case referralLabel

    var font: Font {
        switch self {
        case .heading1: return Font.lato(34, weight: .bold)
        case .heading2: return Font.lato(27, weight: .bold)
        case .heading3: return Font.lato(23, weight: .bold)
        case .heading4: return Font.lato(20, weight: .bold)

        case .body1: return Font.lato(17, weight: .regular)
        case .body1Bold: return Font.lato(17, weight: .bold)
        case .body1Black: return Font.lato(17, weight: .black)
        case .body2: return Font.lato(15, weight: .regular)
        case .body1Semibold: return Font.lato(17, weight: .semibold)
        case .body2Semibold: return Font.lato(15, weight: .semibold)
        case .body2Bold: return Font.lato(15, weight: .bold)
        case .body3: return Font.lato(13, weight: .regular)

        case .label: return Font.lato(17, weight: .black)
        case .detail: return Font.lato(10, weight: .regular)
        case .cardLabel: return Font.robotoMono(17, weight: .regular)
        case .referralLabel: return Font.robotoMono(17, weight: .bold)
        }
    }
}

extension View {
    func baFont(_ font: BAFont) -> some View {
        modifier(BAFontModifier(font: font))
    }
}

struct BAFontModifier: ViewModifier {

    let font: BAFont

    func body(content: Content) -> some View {
        content
            .font(font.font)
    }
}
