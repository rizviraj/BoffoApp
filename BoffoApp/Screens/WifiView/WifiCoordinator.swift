//
//  WifiCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit

enum WifiRoute{
    case wifi
    case pop
}

class WifiCoordinator: BABaseCoordinator<WifiRoute> {
    
    private let navigationSubject = BAPassthroughSubject<WifiRoute>()

    init(navigationController: UINavigationController = UINavigationController()) {
        super.init(navigationController: navigationController)
        navigationSubject.send(.wifi)
    }
    
    override func bindNavigation() {
        navigationSubject
            .sink {[weak self] route in
                switch route{
                case .wifi:
                    self?.showWifi()
                case .pop:
                    self?.pop()
                }
            }
            .store(in: &cancellableBag)
    }
    
    private func showWifi() {
        let viewModel = WifiViewModel()
        
        let view = WifiView(viewModel: viewModel)
        let viewController = UIHostingHiddenNavBarController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
}
