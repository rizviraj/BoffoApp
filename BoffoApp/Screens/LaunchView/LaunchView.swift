//
//  LaunchView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [AppColor.btnPrimaryTop, AppColor.btnPrimaryBottom]), startPoint: .bottomLeading, endPoint: .topTrailing)
 
            VStack{
                BAText("Welcome to", .heading4, AppColor.white)
                BAText("Boffo App", .heading1, AppColor.white)
                    .padding(.top, 10)
                
                Image("ic_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 50)
                    .clipped()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    @ObservedObject private var viewModel: LaunchViewModel
    
    init(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(viewModel: LaunchViewModel())
    }
}

