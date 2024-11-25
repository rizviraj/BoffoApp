//
//  NetworkDisplayItem.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation

struct NetworkDisplayItem: Hashable{
    let id: Int64? = nil
    var interface: String
    var success: Bool = false
    var ssid: String?
    var bssid: String?
}
