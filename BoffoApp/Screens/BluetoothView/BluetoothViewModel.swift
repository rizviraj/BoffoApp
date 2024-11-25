//
//  BluetoothViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine
import CoreBluetooth

final class BluetoothViewModel: BABaseViewModel, ObservableObject{
    
    enum Route{
        //case pop
    }
    // MARK: - Internal computed properties
    var routePublisher: BAAnyPublisher<Route> {
        routeSubject.eraseToAnyPublisher()
    }
    private var routeSubject = BAPassthroughSubject<Route>()
    
    private var manager: BluetoothManager?
    //@Published var devices: [BluetoothDisplayItem] = []
    @Published var bluetoothDisplayItem: [BluetoothDisplayItem] = []
    @Published var connectedDeviceUUID: UUID? = nil
    @Published var buttonTitle: String = "Scan"
    private var isScanNow = false
    
    var scanSubject = BAPassthroughSubject<Void>()
    var connectSubject = BAPassthroughSubject<BluetoothDisplayItem>()
    
    override func bind() {
        manager = BluetoothManager()
        
        scanSubject
            .sink {[weak self] _ in
                self?.processScan()
            }
            .store(in: &cancellables)
        
        manager?.$bluetoothDisplayItems
            .sink(receiveValue: {[weak self] devices in
                self?.bluetoothDisplayItem = devices
            })
            .store(in: &cancellables)
        
        connectSubject
            .sink {[weak self] device in
                self?.manager?.connect(displayItem: device)
            }
            .store(in: &cancellables)
         
        manager?.$errorMessage
            .sink(receiveValue: {[weak self] error in
                self?.errorMessage = error
                self?.clearErrorMessage()
            })
            .store(in: &cancellables)
        
        manager?.$connectedDeviceUUID
            .sink(receiveValue: {[weak self] uuid in
                self?.connectedDeviceUUID = uuid
            })
            .store(in: &cancellables)
        
    }
    
    private func processScan() {
        if isScanNow {
            stopScan()
            isScanNow = false
        }else{
            scan()
            isScanNow = true
        }
        buttonTitle = isScanNow ? "Stop Scan" : "Scan"
    }
    
    private func scan() {
        manager?.startScanning()
    }
    
    private func stopScan() {
        clearDevicesList()
        manager?.stopScan()
    }
    
    private func clearErrorMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){[weak self] in
            self?.errorMessage = nil
        }
    }
    
    private func clearDevicesList() {
        bluetoothDisplayItem = []
    }

}
