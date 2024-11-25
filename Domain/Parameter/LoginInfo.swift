//
//  LoginInfo.swift
//  Domain
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public struct LoginInfo {
    var username: String
    var password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
