//
//  NetworkSession.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public class NetworkSession {
    public static let shared = NetworkSession()
    
    @UserDefaultsBacked(key: NetworkConstant.accessToken)
    public var accessToken: String?
    
}
