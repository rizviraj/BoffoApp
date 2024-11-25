//
//  BackButton.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        HStack{
            Image("ic_back")
                .renderingMode(.template)
                .foregroundColor(color)
                .frame(width: 50, height: 50, alignment: .leading)
            Spacer()
        }
        .onTapGesture {
            action()
        }
    }
    
    let color: Color
    let action: () -> Void
    
    init(color: Color = AppColor.black, action: @escaping () -> Void) {
        self.color = color
        self.action = action
    }
    
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(color: AppColor.titleGray, action: {})
    }
}
