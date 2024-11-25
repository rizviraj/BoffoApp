//
//  APIService.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

public protocol APIServiceDelegate{
    func requestAsync<T: Decodable>(with builder: RequestBuilder) async throws -> T
}

public class APIService: NSObject, APIServiceDelegate {

    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    public func requestAsync<T: Decodable>(with builder: RequestBuilder) async throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            try await self.isTokenExpired()
            let (data, response) = try await URLSession.shared.data(for: builder.urlRequest, delegate: self)
            
            guard let httpRes = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            if let JSONString = String(data: data, encoding: String.Encoding.utf8){
                print(JSONString)
            }
            if (200..<300).contains(httpRes.statusCode) {
                return try decoder.decode(T.self, from: data)
            }else{
                throw APIError.decodingError
            }
         
        } catch {
            throw APIError.mapError(error)
        }
    }
    
}

extension APIService: URLSessionTaskDelegate {
    
    //MARK: - Todo -  Use this method to block Man In the Middle attack
    //Use publich key pinning or certificate pinning
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        //For now use success
        return (.useCredential, nil)
    }
}


extension APIService {
    private func isTokenExpired() async throws{
        guard let token = NetworkSession.shared.accessToken else { return }
        
        do{
            let jwt = self.decodeJwt(from: token)
            let tokenValue = self.convertToken(text: jwt)
            let currentTime = Int64(Date().timeIntervalSince1970)
            if tokenValue?.exp ?? 0 <= currentTime {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {[weak self] in
                    guard let _ = self else { return }
                }
                throw APIError.tokenExpired
            }
        }catch{
            throw APIError.mapError(error)
        }
    }
    
    private func convertToken(text: String) -> TokenItems? {
        if let data = text.data(using: .utf8) {
            do {
                let product = try JSONDecoder().decode(TokenItems.self, from: data)
                return product
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    private func decodeJwt(from jwt: String) -> String {
        let segments = jwt.components(separatedBy: ".")
        
        var base64String = segments[1]
        
        let requiredLength = Int(4 * ceil(Float(base64String.count) / 4.0))
        let nbrPaddings = requiredLength - base64String.count
        if nbrPaddings > 0 {
            let padding = String().padding(toLength: nbrPaddings, withPad: "=", startingAt: 0)
            base64String = base64String.appending(padding)
        }
        base64String = base64String.replacingOccurrences(of: "-", with: "+")
        base64String = base64String.replacingOccurrences(of: "_", with: "/")
        let decodedData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions(rawValue: UInt(0)))
        
        let base64Decoded: String = String(data: decodedData! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        return base64Decoded
    }
}
