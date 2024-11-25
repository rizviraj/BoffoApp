//
//  BAButtonStyle.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BAButtonStyle: ButtonStyle {

    let style: BAButtonConfiguration

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .baFont(.heading4)
            .foregroundColor(style.textColor)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
