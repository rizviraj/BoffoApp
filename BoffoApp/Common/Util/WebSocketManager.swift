//
//  WebSocketManager.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
        
    private var webSocket: URLSessionWebSocketTask?
    
    @Published var recievedMessage: String = ""
    @Published var errorMessage: String? = nil
    var isAnimating = BAPassthroughSubject<Bool>()
    var isConnected = BAPassthroughSubject<Bool>()
    
    //MARK: - Connect to the server
    func connect() {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        guard let url = URL(string: "wss://echo.websocket.org") else {
            self.errorMessage = "Could not find the url"
            return
        }
        
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
        isAnimating.send(true)
    }
    
    func ping(){
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let error = error {
                self.errorMessage = "Websocket Error \(error)"
                //print("Websocket Error \(error)")
            }
        })
    }
    
    func close() {
        webSocket?.cancel()
    }
    
    //MARK: - Sending messages
    func send(message: String){
        webSocket?.send(.string(message), completionHandler: { error in
            if let error = error {
                self.errorMessage = "Sending message failed with \(error)"
                //print("Sending message failed with \(error)")
            }
        })
    }
    
    //MARK: - Receiving messages
    func receive() {
        webSocket?.receive(completionHandler: {[weak self] results in
            switch results {
            case .success(let message):
                switch message {
                case .data(let data):
                    self?.recievedMessage = "Received data - \(data)"
                case .string(let string):
                    self?.recievedMessage = "Received String - \(string)"
                default:
                    break
                }
            case .failure(let error):
                self?.errorMessage = "Received error \(error)"
            }
            
            self?.receive()
        })
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        isAnimating.send(false)
        isConnected.send(true)
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.errorMessage = "Close server"
        isAnimating.send(false)
    }
}
