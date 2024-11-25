//
//  User.swift
//  Domain
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public struct User: Decodable{
    public var id: Int64?
    public let firstName: String?
    public let lastName: String?
    public let email: String?
    public let mobileNumber: Int64?
    public let countryCode: String?
    public let address: String?
    public let city: String?
    public let country: String?
}
