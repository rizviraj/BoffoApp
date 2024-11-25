//
//  LoginViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine
import SwiftUI
import KeychainSwift
import Domain

final class LoginViewModel: ObservableObject {
    
    enum Route{
        case loginSuccess
    }
    
    // MARK: - Internal computed properties
    var routePublisher: BAAnyPublisher<Route> {
        routeSubject.eraseToAnyPublisher()
    }
    var routeSubject = BAPassthroughSubject<Route>()
    
    var cancellables = Set<AnyCancellable>()
    private var authService: AuthServiceDelegate?
    var loginSubject = BAPassthroughSubject<Void>()
    var rememberSubject = BAPassthroughSubject<Void>()
    
    let keychain = KeychainSwift()
    
    @Published var isAnimating = false
    @Published var errorMessage: String? = nil
    @Published var isRemember: Bool = false
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var usernameBorderColor: Color = AppColor.lineGray
    @Published var passwordBorderColor: Color = AppColor.lineGray
    
    var isLoginEnable: Bool{
       return username.isValidText && password.isValidText
    }
    
    init(authService: AuthServiceDelegate? = AuthService()) {
        self.authService = authService
        
        bind()
    }
    
    private func bind() {
        checkKeychainValues()
        
        loginSubject
            .sink {[weak self] _ in
                if self?.isLoginEnable == true { self?.login() }
            }
            .store(in: &cancellables)
        
        $username
            .dropFirst()
            .sink {[weak self] text in
                self?.usernameBorderColor = text.isValidText || text == "" ? AppColor.lineGray : AppColor.red
                
            }
            .store(in: &cancellables)
        
        $password
            .dropFirst()
            .sink {[weak self] text in
                self?.passwordBorderColor = text.isValidText || text == "" ? AppColor.lineGray : AppColor.red
            }
            .store(in: &cancellables)
 
    }
    
    //MARK: - store user credentails in keychian
    private func processRememberCredentials() {
        if isRemember {
            keychain.set(username, forKey: "username")
            keychain.set(password, forKey: "password")
        }else{
            keychain.delete("username")
            keychain.delete("password")
            keychain.clear()
        }
    }
    
    //MARK: - get credentials from keychain if it exists
    private func checkKeychainValues() {
        guard let user = keychain.get("username"), let pass = keychain.get("password") else { return }
        username = user
        password = pass
    }
    
    //MARK: - Todo When you want to make rest API call use this method
    
    private func loginApi() {
        self.isAnimating = true
        let info = LoginInfo(username: username, password: password)
        Task{ @MainActor in
            let userInfo = await self.authService?.login(loginInfo: info)
            self.isAnimating = false
            switch userInfo{
            case.success(let user):
                print(user)
                
                //Todo - handle success login
                //Save token
                //Sale logged in state
                //Redirect
                self.routeSubject.send(.loginSuccess)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            case .none:
                self.errorMessage = "Pleae try again"
            }
        }
    }
    
    //MARK: - Use this method for hardcoded login for now
    
    private func login() {
        processRememberCredentials()
        
        if username.lowercased() == "admin" && password == "admin".lowercased() {
            print("Login success")
            routeSubject.send(.loginSuccess)
        }else{
            errorMessage = "Invalid login"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
                self?.errorMessage = nil
            }
        }
    }
    
    
   
}
