//
//  AppConfiguration.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit

class AppConfiguration {
    
    private var window: UIWindow?

    func start(withWindow window: UIWindow) {
        // Initialize application
        Application.shared.configureMainInterface(in: window)
    }
    
}
