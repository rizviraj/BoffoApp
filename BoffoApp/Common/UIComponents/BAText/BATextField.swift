//
//  BATextField.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BATextField: View {

    var body: some View {
        Group {
            if isSecure {
                SecureField("", text: $text)
            } else {
                if isForPrice == true {
                    ZStack(alignment: .leading){
                        TextField("", text: $text)
                            .autocorrectionDisabled()
                        BAText("LKR", .body2, AppColor.titleGray)
                            .padding(.leading, 10)
                    }
                }else{
                    TextField("", text: $text)
                        .autocorrectionDisabled()
                }
            }
        }
        .textFieldStyle(BATextFieldStyle(text: $text,
                                         borderColor: $borderColor,
                                         style: style,
                                         placeholder: placeholder, isForPrice: isForPrice))
    }

    @State var isSecure: Bool = false
    @Binding var text: String
    @Binding var borderColor: Color
    let placeholder: LocalizedStringKey
    let style: BATextFieldConfiguration
    var isForPrice: Bool = false
}
