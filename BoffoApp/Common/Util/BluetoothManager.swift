//
//  BluetoothManager.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import CoreBluetooth

final class BluetoothManager: NSObject{
    private var centralManager: CBCentralManager?
    
    @Published var bluetoothDisplayItems: [BluetoothDisplayItem] = []
    
    @Published var devices: [CBPeripheral] = []
    @Published var errorMessage: String? = nil
    @Published var connectedDeviceUUID: UUID? = nil
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    
    func startScanning() {
        self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func connect(displayItem: BluetoothDisplayItem) {
        guard let device = centralManager?.retrievePeripherals(withIdentifiers: [displayItem.id]).first else {
            errorMessage = "No Bluetooth device found"
            return
        }
        connectedDeviceUUID = device.identifier
        centralManager?.connect(device, options: nil)
    }
    
    func stopScan() {
        clearScanDevices()
        centralManager?.stopScan()
    }
    
    private func clearScanDevices() {
        connectedDeviceUUID = nil
        bluetoothDisplayItems = []
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            self.centralManager?.stopScan()
        }
        
        switch central.state {
        case .unknown:
            errorMessage = "Nnknown Device"
        case .resetting:
            errorMessage = "Resetting"
        case .unsupported:
            errorMessage = "Unsupported"
        case .unauthorized:
            errorMessage = "Unauthorized"
        case .poweredOff:
            errorMessage = "Powered off"
        case .poweredOn:
            print("powered on")
        @unknown default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let displayItem = BluetoothDisplayItem(id: peripheral.identifier, name: peripheral.name ?? "Unknown Device", rssi: RSSI.intValue)
        
        if !self.bluetoothDisplayItems.contains(where: {$0.id == displayItem.id}) {
            //peripheral.delegate = self
            self.bluetoothDisplayItems.append(displayItem)
        }
        print("Count - \(self.bluetoothDisplayItems.count)")
    }
 
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
        print("Connected")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        errorMessage = "Disconnected from \(peripheral.name ?? "Unknown device")"
        if peripheral.identifier == connectedDeviceUUID {
            connectedDeviceUUID = nil
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        errorMessage = "Error from \(error?.localizedDescription ?? "Unknown device")"
        if peripheral.identifier == connectedDeviceUUID {
            connectedDeviceUUID = nil
        }
    }
    
}


