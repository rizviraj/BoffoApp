//
//  UserDefaultsBacked.swift
//  NetworkPlatform
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
public struct UserDefaultsBacked<Value: Codable> {
    let key: String
    let defaultValue: Value
    var storage: UserDefaults = .standard
    let encoder: JSONEncoder = NetworkConstant.jsonEncoder
    let decoder: JSONDecoder = NetworkConstant.jsonDecoder
    //let decoder1: JSONDecoder = NetworkConstant.jsonDecoder1

    public var wrappedValue: Value {
        get {
            if let jsonString = storage.value(forKey: key) as? String,
               let jsonData = jsonString.data(using: .utf8) {
                if let value = try? decoder.decode(Value.self, from: jsonData) {
                    return value
                }
                //if let value = try? decoder1.decode(Value.self, from: jsonData) {
                //    return value
                //}
                return defaultValue
            } else {
                let value = storage.value(forKey: key) as? Value
                return value ?? defaultValue
            }
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                if let jsonData = try? encoder.encode(newValue) {
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    storage.setValue(jsonString, forKey: key)
                } else {
                    storage.setValue(newValue, forKey: key)
                }
            }
        }
    }
}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }
}

struct TokenItems: Codable{
    let exp: Int64
}
