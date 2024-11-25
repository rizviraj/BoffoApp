//
//  TabItems.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit

enum TabItems: CaseIterable {
    case home
    case bluetooth
    case wifi
    case tcp
    
    static var allTabs: [TabItems] {
        return [.home, .bluetooth, .wifi, .tcp]
    }
    
    var tabName: String {
        switch self{
        case .home: return "Home"
        case .bluetooth: return "Bluetooth"
        case .wifi: return "Wi-Fi"
        case .tcp: return "TCP Server"
        }
    }
    
    var tabImage: UIImage? {
        switch self{
        case .home: return UIImage(named: "ic_home")
        case .bluetooth: return UIImage(named: "ic_bluetooth")
        case .wifi: return UIImage(named: "ic_wifi")
        case .tcp: return UIImage(named: "ic_tcp")
        }
    }
    
    var tabImageSelected: UIImage? {
        switch self{
        case .home: return UIImage(named: "ic_home")
        case .bluetooth: return UIImage(named: "ic_bluetooth")
        case .wifi: return UIImage(named: "ic_wifi")
        case .tcp: return UIImage(named: "ic_tcp")
        }
    }
}
