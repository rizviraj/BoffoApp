//
//  WifiManager.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-24.
//

import Foundation
import CoreLocation
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork

final class WifiManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    @Published var networkDisplayItems: [NetworkDisplayItem] = []
    @Published var errorMessage: String? = nil
    
    func setupLocation() {
        if #available(iOS 13.0, *) {
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                fetchNetworkInfo()
            case .restricted, .denied:
                errorMessage = "Permission deniged"
            default:
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        }else{
            fetchNetworkInfo()
        }
    }
    
    //MARK: - get all wifi 
    func fetchNetworkInfo() {
        if let interfaces: NSArray = CNCopySupportedInterfaces() {
            for interface in interfaces {
                let interfaceName = interface as! String
                var displayItem = NetworkDisplayItem(interface: interfaceName, success: false, ssid: nil, bssid: nil)
                
                if let dic = CNCopyCurrentNetworkInfo(interfaceName as CFString) as NSDictionary? {
                    displayItem.success = true
                    displayItem.ssid = dic[kCNNetworkInfoKeySSID as String] as? String
                    displayItem.bssid = dic[kCNNetworkInfoKeyBSSID as String] as? String
                }
                networkDisplayItems.append(displayItem)
            }
        }
    }
    
}

extension WifiManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            fetchNetworkInfo()
        }
    }
}
