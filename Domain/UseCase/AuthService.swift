//
//  AuthService.swift
//  Domain
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation
import Combine
import NetworkPlatform

public protocol AuthServiceDelegate{
    
    var apiSession: APIServiceDelegate { get }
    func login(loginInfo: LoginInfo) async -> Result<User, Error>
}

public class AuthService: AuthServiceDelegate {
    
    public let apiSession: APIServiceDelegate
    
    public init(apiSession: APIServiceDelegate = APIService()) {
        self.apiSession = apiSession
    }
    
    public func login(loginInfo: LoginInfo) async -> Result<User, Error> {
        let loginParam = LoginParam(username: loginInfo.username, password: loginInfo.password)
        do{
            let result: User = try await apiSession.requestAsync(with: BAEndpoint.login(loginParam: loginParam))
            return .success(result)
        }catch let error {
            return .failure(error)
        }
    }
    
    public func updateToken(token: String){
        NetworkSession.shared.accessToken = token
    }
}
