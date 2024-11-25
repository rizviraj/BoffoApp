//
//  TCPView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct TCPView: View {
    var body: some View {
        ZStack{
            VStack{
                NavigationViewPlain(title: "TCP Server", isBackActive: false)
                    .padding(.horizontal, -15)
                
                mainContentView
            }
            .padding(.horizontal, 15)
            if viewModel.isAnimating { LoadingView() }
        }
    }
    
    @ObservedObject private var viewModel: TCPViewModel
    
    init(viewModel: TCPViewModel) {
        self.viewModel = viewModel
    }
    
    private func connect() {
        viewModel.connectSubject.send()
    }
    
    private func send() {
        viewModel.sendSubject.send()
    }
}

struct TCPView_Previews: PreviewProvider {
    static var previews: some View {
        TCPView(viewModel: TCPViewModel())
    }
}

extension TCPView {
    
    private var mainContentView: some View {
        VStack{
            connectionView
            .padding(.top, 20)
            
            messageView
            .padding(.top, 20)
        }
    }
    
    private var connectionView: some View {
        VStack(spacing: 15){
            if viewModel.errorMessage != nil {
                BAText(LocalizedStringKey(viewModel.errorMessage ?? ""), .body1, AppColor.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(AppColor.red)
                    .cornerRadius(5)
            }
            if viewModel.isConnected {
                BAText("Connection Established", .body1, AppColor.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(AppColor.titleGray)
                    .cornerRadius(5)
                
                BATextField(text: $viewModel.message, borderColor: $viewModel.messageBorder, placeholder: "Message", style: .primary)
                
                BAButton(text: "Send Message", style: viewModel.isButtonEnable ?  .blueButton : .desable, action: send)
                
            }else{
                BAButton(text: "Connect", style: .primary, action: connect)
            }
        }
    }
    
    private var messageView: some View {
        ScrollView{
            ForEach(viewModel.receivedMessage, id: \.self) { message in
                VStack(alignment: .leading){
                    BAText(LocalizedStringKey(message), .body1, AppColor.titleGray)
                        .padding(.vertical, 5)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(AppColor.backGray)
                }
            }
        }
    }
}
