//
//  NavigationViewPlain.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct NavigationViewPlain: View {
    var body: some View {
        ZStack(alignment: .trailing){
            ZStack(alignment: .leading){
                if isBackActive {
                    BackButton(color: AppColor.white, action: backTrigger)
                        .frame(width: 50, height: 50)
                }
                
                BAText(LocalizedStringKey(title), .heading3, AppColor.white)
                    .frame(height: 40, alignment: .center)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [AppColor.btnPrimaryTop, AppColor.btnPrimaryBottom]), startPoint: .bottomLeading, endPoint: .topTrailing)
            )
    }
    
    var title: String
    var isBackActive: Bool = true
    var action: () -> Void = {}
    
    private func backTrigger() {
        action()
    }
}

struct NavigationViewPlain_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewPlain(title: "Title", action: {})
    }
}
