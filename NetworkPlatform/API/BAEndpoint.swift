//
//  BAEndpoint.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//


import Foundation
import SwiftUI

private struct Constants {
    static let api = BABaseAPI.dev
}

public enum BAEndpoint {
    case login(loginParam: LoginParam)
    
}

extension BAEndpoint: RequestBuilder {
    public var urlRequest: URLRequest {
        switch self{
     
        case .login(let loginParam):
            return buildRequest(endpoint: "auth/login",
                                method: .post,
                                parameters: loginParam,
                                headers: BAHeaderManger.shared.basicHeader)
    
        }
        
    }

    private func buildRequest<S: Encodable>(usingOutsideAPI: Bool = false,
                                            endpoint: String,
                                            method: RestMethod,
                                            parameters: S?,
                                            headers: BAHTTPHeaders) -> URLRequest {
        let base = usingOutsideAPI ? "" : Constants.api.rawValue
        guard let url = URL(string: base+endpoint) else {
            preconditionFailure("Invalid URL format") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            print("Encoding error")
        }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }

    private func buildRequest(usingOutsideAPI: Bool = false,
                              endpoint: String,
                              method: RestMethod,
                              headers: BAHTTPHeaders) -> URLRequest {
        let base = usingOutsideAPI ? "" : Constants.api.rawValue
        guard let url = URL(string: base+endpoint) else {
            preconditionFailure("Invalid URL format") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }

    private func convertFileData(fieldName: String,
                                 fileName: String,
                                 mimeType: String,
                                 fileData: Data,
                                 using boundary: String) -> Data {
        let data = NSMutableData()

        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")

        return data as Data
    }

}


extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
}
