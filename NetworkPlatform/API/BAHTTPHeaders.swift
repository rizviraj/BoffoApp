//
//  BAHTTPHeaders.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public typealias BAHTTPHeaders = [String: String]

//MARK: - change these url based on your domain
enum BABaseAPI: String {
    case dev = "http://localhost:3000/"
    case production = "https://example.org/v1/"
}

enum RestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum BAHeaderHTTPField: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum BAContentType: String {
    case json = "application/json"
}

class BAHeaderManger {

    static let shared = BAHeaderManger()

    var basicHeader: BAHTTPHeaders {
        return [BAHeaderHTTPField.contentType.rawValue: BAContentType.json.rawValue]
    }

    var headers: BAHTTPHeaders {
        getHeaders(contentType: .json)
    }

    func pinataHeader(token: String) -> BAHTTPHeaders {
        let headers = [
            BAHeaderHTTPField.contentType.rawValue: BAContentType.json.rawValue,
            BAHeaderHTTPField.authorization.rawValue: "Bearer \(token)"
        ]
        return headers
    }

    private func getHeaders(contentType: BAContentType) -> BAHTTPHeaders {
        var headers = [
            BAHeaderHTTPField.contentType.rawValue: contentType.rawValue
        ]
        if let token = NetworkSession.shared.accessToken {
            headers[BAHeaderHTTPField.authorization.rawValue] = "Bearer \(token)"
        }
        print(headers)
        return headers
    }
}

