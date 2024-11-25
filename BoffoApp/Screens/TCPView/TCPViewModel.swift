//
//  TCPViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine
import SwiftUI

final class TCPViewModel: BABaseViewModel, ObservableObject{
    
    enum Route{
        //case pop
    }
    // MARK: - Internal computed properties
    var routePublisher: BAAnyPublisher<Route> {
        routeSubject.eraseToAnyPublisher()
    }
    private var routeSubject = BAPassthroughSubject<Route>()
    
    private var websocketManager: WebSocketManager?
    
    @Published var isConnected: Bool = false
    @Published var message: String = ""
    @Published var messageBorder: Color = AppColor.lineGray
    @Published var receivedMessage:[String] = []
    
    var connectSubject = BAPassthroughSubject<Void>()
    var sendSubject = BAPassthroughSubject<Void>()
    
    var isButtonEnable: Bool{
        return message.isBasicValidText
    }
    
    override func bind() {
        websocketManager = WebSocketManager()
        
        $message
            .dropFirst()
            .sink {[weak self] text in
                self?.messageBorder = text.isBasicValidText || text == "" ? AppColor.lineGray : AppColor.red
            }
            .store(in: &cancellables)
        
        websocketManager?.isConnected
            .map{$0}
            .assign(to: &$isConnected)
        
        websocketManager?.isAnimating
            .map{$0}
            .assign(to: &$isAnimating)
        
        websocketManager?.$recievedMessage
            .sink(receiveValue: {[weak self] message in
                self?.receivedMessage.append(message)
            })
            .store(in: &cancellables)
        
        websocketManager?.$errorMessage
            .sink(receiveValue: {[weak self] error in
                self?.errorMessage = error
                self?.clearErrorMessage()
            })
            .store(in: &cancellables)
        
        connectSubject
            .sink {[weak self] _ in
                self?.connect()
            }
            .store(in: &cancellables)
        
        sendSubject
            .sink {[weak self] _ in
                self?.send()
            }
            .store(in: &cancellables)
            
    }

    func connect() {
        websocketManager?.connect()
    }
    
    func send() {
        if isButtonEnable {
            websocketManager?.send(message: message)
            clearMessage()
        }
    }
    
    func clearMessage() {
        message = ""
    }
    
    private func clearErrorMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){[weak self] in
            self?.errorMessage = nil
        }
    }
    
}
