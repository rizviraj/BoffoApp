//
//  APIError.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public enum APIError: Error, LocalizedError {
    case invalidResponse
    case decodingError
    case invalidData
    case httpError(String)
    case tokenExpired
    case unknown
    case mapError(Error)
    
    public var errorDescription: String?{
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .decodingError:
            return "Decoding Error"
        case .invalidData:
            return "Invalid data"
        case .tokenExpired:
            return "Token Expired"
        case .unknown:
            return "Unknown error"
        case .mapError(let error):
            return error.localizedDescription
        default:
            return "Please try again"
        }
    }
}

public struct NAError: Codable {
    let status: Int
    let code: String

    enum CodingKeys: String, CodingKey {
        case status, code
    }
}
