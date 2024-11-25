//
//  Application.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit
//import Domain
import Combine

class Application {
    static let shared = Application()
    private var window: UIWindow?
    
    var cancellables = Set<AnyCancellable>()
    private var coordinator: AppCoordinator?
    private var isInitialLaunch: Bool = false
    private let notificationCenter = NotificationCenter.default

    
    private init() {
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAppWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAppWillEnterBackground),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
        
    }
    
    func configureMainInterface(in window: UIWindow) {
        self.window = window
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        window.makeKeyAndVisible()
        
        self.isInitialLaunch = true
    }
    
    //MARK: - Todo Manage log out here
    func logOut() {
        
    }
    
    //MARK: - Handle when app enter to foreground
    @objc public func handleAppWillEnterForeground() {
        
    }
    
    //MARK: - Handle when app enter to background
    @objc public func handleAppWillEnterBackground() {
        
    }
    
}
