//
//  BluetoothView.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import SwiftUI

struct BluetoothView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 10){
                NavigationViewPlain(title: "Bluetooth", isBackActive: false)
                    .padding(.horizontal, -15)
                
                mainContentView
            }
        }
        .padding(.horizontal, 15)
    }
    
    @ObservedObject private var viewModel: BluetoothViewModel
    
    init(viewModel: BluetoothViewModel) {
        self.viewModel = viewModel
    }
    
    private func scan() {
        //viewModel.isScanNow.toggle()
        viewModel.scanSubject.send()
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView(viewModel: BluetoothViewModel())
    }
}

extension BluetoothView {
    
    private var mainContentView: some View {
        VStack(spacing: 15){
            BAButton(text: LocalizedStringKey(viewModel.buttonTitle), style: .primary, action: scan)
                .padding(.top, 20)
            
            if viewModel.errorMessage != nil {
                BAText(LocalizedStringKey(viewModel.errorMessage ?? ""), .body1, AppColor.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(AppColor.red)
                    .cornerRadius(5)
            }
            deviceListView
                .padding(.top, 20)
        }
    }
    
    private var deviceListView: some View {
        ScrollView{
            VStack(alignment: .leading){
                BAText("List of Bluetooth Devices", .heading4, AppColor.titleGray)
                    .padding(.bottom, 10)
                if viewModel.bluetoothDisplayItem.count > 0 {
                    ForEach(viewModel.bluetoothDisplayItem){ device in
                        HStack{
                            VStack(alignment: .leading){
                                BAText(LocalizedStringKey(device.name), .body1, AppColor.titleGray)
                                BAText(LocalizedStringKey("\(device.id)"), .body2, AppColor.darkGray)
                            }
                            Spacer()
                            if viewModel.connectedDeviceUUID == device.id {
                                BAText("Connected", .body1, AppColor.primaryGreen)
                            }
                        }
                        .background(AppColor.white)
                        .onTapGesture {
                            viewModel.connectSubject.send(device)
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(AppColor.backGray)
                    }
                }else{
                    BAText("0 Device found", .body1, AppColor.titleGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
