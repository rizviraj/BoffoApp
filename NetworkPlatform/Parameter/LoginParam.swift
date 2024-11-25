//
//  LoginParam.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public struct LoginParam: Encodable{
    let username: String
    let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
