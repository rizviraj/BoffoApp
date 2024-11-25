//
//  WifiViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import SwiftUI
import Combine
import NetworkExtension

final class WifiViewModel: BABaseViewModel, ObservableObject{
    
    enum Route{
        //case pop
    }
    // MARK: - Internal computed properties
    var routePublisher: BAAnyPublisher<Route> {
        routeSubject.eraseToAnyPublisher()
    }
    private var routeSubject = BAPassthroughSubject<Route>()
    
    private var manager: WifiManager?
    var getWifiSubject = BAPassthroughSubject<Void>()
    
    @Published var networkDisplayItems: [NetworkDisplayItem] = []
    var selectedNetwork: NetworkDisplayItem? = nil
    @Published var isShowPassword: Bool = false
    @Published var password: String = ""
    @Published var passwordBorder: Color = AppColor.lineGray
    @Published var connectedMessage: String? = nil
    
    var selectedNetworkSubject = BAPassthroughSubject<NetworkDisplayItem>()
    var connectSubject = BAPassthroughSubject<Void>()
    
    override func bind() {
        manager = WifiManager()
        
        getWifiSubject
            .sink { [weak self] _ in
                self?.getWifiList()
            }
            .store(in: &cancellables)
  
        manager?.$networkDisplayItems
            .sink(receiveValue: {[weak self] wifi in
                self?.networkDisplayItems = wifi
            })
            .store(in: &cancellables)
        
        selectedNetworkSubject
            .sink(receiveValue: {[weak self] displayItem in
                self?.isShowPassword = true
                self?.selectedNetwork = displayItem
            })
            .store(in: &cancellables)
        
        connectSubject
            .sink { [weak self] in
                self?.connectToWifi()
                self?.isShowPassword = false
            }
            .store(in: &cancellables)
        
        manager?.$errorMessage
            .sink(receiveValue: {[weak self] error in
                self?.errorMessage = error
                self?.clearErrorMessage()
            })
            .store(in: &cancellables)
        
    }

    private func getWifiList() {
        manager?.setupLocation()
    }
    
    private func connectToWifi() {
        guard let ssid = selectedNetwork?.ssid else { return }
        let configuration = NEHotspotConfiguration.init(ssid: ssid, passphrase: password, isWEP: false)
        configuration.joinOnce = true

        NEHotspotConfigurationManager.shared.apply(configuration) {[weak self] (error) in
            if error != nil {
                self?.errorMessage = error?.localizedDescription
                self?.clearErrorMessage()
            }else {
                self?.connectedMessage = "Connected Successfully"
            }
            self?.password = ""
        }
    }
    
    private func clearErrorMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){[weak self] in
            self?.errorMessage = nil
        }
    }
    
}
