//
//  BAText.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BAText: View {
    var body: some View {
        Text(text)
            .baFont(font)
            .foregroundColor(color)
    }
    
    let text: LocalizedStringKey
    let font: BAFont
    let color: Color
    
    init(_ text: LocalizedStringKey, _ font: BAFont, _ color: Color) {
        self.text = text
        self.font = font
        self.color = color
    }
}
