//
//  BAButton.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BAButton: View {

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                if let imageName = image,
                   let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .renderingMode(isTemplate ? .template : .original)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(style.textColor)
                }
                Text(text)
            }
        }
        .buttonStyle(BAButtonStyle(style: style))
    }

    let text: LocalizedStringKey
    let image: String?
    let style: BAButtonConfiguration
    let isTemplate: Bool
    let action: () -> Void

    init(text: LocalizedStringKey,
         image: String? = nil,
         style: BAButtonConfiguration,
         isTemplate: Bool = true,
         action: @escaping () -> Void) {
        self.text = text
        self.image = image
        self.style = style
        self.isTemplate = isTemplate
        self.action = action
    }
}
