//
//  RequestBuilder.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public protocol RequestBuilder {
    var urlRequest: URLRequest { get }
}
