//
//  LoginView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 10){
                NavigationViewPlain(title: "Login", isBackActive: false)
                    .padding(.horizontal, -15)
                
                mainContentView
                
                Spacer()
            }
            .padding(.horizontal, 15)
        }
    }
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    private func login() {
        viewModel.loginSubject.send()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}


extension LoginView {
    private var mainContentView: some View {
        VStack(alignment: .leading, spacing: 15){
            BAText("User Authentication", .heading4, AppColor.titleGray)
            BATextField(text: $viewModel.username, borderColor: $viewModel.usernameBorderColor, placeholder: "Username", style: .primary)
            BATextField(isSecure: true, text: $viewModel.password, borderColor: $viewModel.passwordBorderColor, placeholder: "Password", style: .primary)
            
            HStack{
                BAImage(viewModel.isRemember ? "ic_box_checked" : "ic_box", 20,20, .template)
                    .foregroundColor(AppColor.darkGray)
                BAText("Remember", .body1, AppColor.darkGray)
                Spacer()
            }
            .frame(height: 30)
            .background(AppColor.white)
            .onTapGesture {
                viewModel.isRemember.toggle()
            }
            if viewModel.errorMessage != nil {
                BAText(LocalizedStringKey(viewModel.errorMessage ?? ""), .body2, AppColor.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            BAButton(text: "Login", style: viewModel.isLoginEnable == true ? .primary : .desable, action: login)
                .padding(.top, 20)
            
            demoLoginView
        }
        .padding(.top, 30)
    }
    
    private var demoLoginView: some View {
        VStack(alignment: .leading, spacing: 10){
            BAText("Use this Demo Credentials", .body1, AppColor.titleGray)
            HStack(spacing: 20){
                BAText("username : ", .body2, AppColor.darkGray)
                BAText("admin", .body2, AppColor.titleGray)
            }
            HStack(spacing: 20){
                BAText("password : ", .body2, AppColor.darkGray)
                BAText("admin", .body2, AppColor.titleGray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppColor.lineGray)
                
        )
    }
}
