//
//  BATextFieldStyle.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BATextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if !text.isEmpty {
                BAText(placeholder, .detail, AppColor.darkGray)
                    .padding(.leading, isForPrice == true ? -40 : 0)
            }
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    BAText(placeholder, .body2, AppColor.darkGray)
                }
                configuration
                    .baFont(.body1)
                    .foregroundColor(AppColor.titleGray)
            }
        }
        .padding(.horizontal, isForPrice == true ? 45 : 10)
        .padding(.bottom, 20)
        .padding(.top, text.isEmpty ? 20 : 8)
        //.background(style.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(borderColor, lineWidth: 1)
        )
        //.cornerRadius(5)
        .animation(.easeInOut, value: text.isEmpty)
    }

    @Binding var text: String
    @Binding var borderColor: Color
    let style: BATextFieldConfiguration
    let placeholder: LocalizedStringKey
    var isForPrice: Bool = false
}
