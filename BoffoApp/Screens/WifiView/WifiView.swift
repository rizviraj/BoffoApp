//
//  WifiView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct WifiView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                NavigationViewPlain(title: "Wifi", isBackActive: false)
                    .padding(.horizontal, -15)
                
                mainContentView
            }
            .sheet(isPresented: $viewModel.isShowPassword){
                passwordView
            }
        }
        .padding(.horizontal, 15)
    }
    
    @ObservedObject private var viewModel: WifiViewModel
    
    init(viewModel: WifiViewModel) {
        self.viewModel = viewModel
    }
    
    private func getWifi() {
        viewModel.getWifiSubject.send()
    }
    
    private func connect() {
        viewModel.connectSubject.send()
    }
}

struct WifiView_Previews: PreviewProvider {
    static var previews: some View {
        WifiView(viewModel: WifiViewModel())
    }
}


extension WifiView {
    private var mainContentView: some View {
        VStack(alignment: .leading) {
            BAButton(text: "Get Wifi List", style: .primary, action: getWifi)
                .padding(.top, 20)
            
            if viewModel.connectedMessage != nil {
                BAText(LocalizedStringKey(viewModel.connectedMessage ?? "Connected"), .body1, AppColor.white)
                    .padding(.horizontal, 15)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(AppColor.primaryGreen)
                    .cornerRadius(10)
            }
            if viewModel.errorMessage != nil {
                BAText(LocalizedStringKey(viewModel.errorMessage ?? ""), .body1, AppColor.white)
                    .padding(.horizontal, 15)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(AppColor.red)
                    .cornerRadius(10)
            }
            
            wifiListView
        }
    }
    
    private var wifiListView: some View {
        ScrollView {
            VStack(alignment: .leading){
                BAText("Wifi List", .heading4, AppColor.titleGray)
                    .padding(.vertical, 10)
                
                if viewModel.networkDisplayItems.count > 0 {
                    ForEach(viewModel.networkDisplayItems, id: \.self){ network in
                        VStack(alignment: .leading, spacing: 5){
                            BAText("Home Network", .body1, AppColor.titleGray)
                            BAText("Home-3394955999", .body2, AppColor.darkGray)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppColor.white)
                        .onTapGesture {
                            viewModel.selectedNetworkSubject.send(network)
                            //viewModel.isShowPassword = true
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(AppColor.backGray)
                    }
                }else{
                    BAText("0 Wifi found", .body1, AppColor.titleGray)
                    
                }
            }
        }
    }
    
    private var passwordView: some View {
        VStack{
            BATextField(isSecure: true, text: $viewModel.password, borderColor: $viewModel.passwordBorder, placeholder: "Password", style: .primary)
                .padding(.top, 20)
                
            BAButton(text: "Connect", style: .primary, action: connect)
                .padding(.top, 10)
           Spacer()
        }
        .padding(.horizontal, 15)
        //.presentationDetents([.height(200)])
        //.presentationDragIndicator(.visible)
    }
}
