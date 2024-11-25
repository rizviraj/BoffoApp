//
//  BluetoothCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit

enum BluetoothRoute{
    case bluetooth
    case pop
}

class BluetoothCoordinator: BABaseCoordinator<BluetoothRoute> {
    
    private let navigationSubject = BAPassthroughSubject<BluetoothRoute>()

    init(navigationController: UINavigationController = UINavigationController()) {
        super.init(navigationController: navigationController)
        navigationSubject.send(.bluetooth)
    }
    
    override func bindNavigation() {
        navigationSubject
            .sink {[weak self] route in
                switch route{
                case .bluetooth:
                    self?.showBluetooth()
                case .pop:
                    self?.pop()
                }
            }
            .store(in: &cancellableBag)
    }
    
    private func showBluetooth() {
        let viewModel = BluetoothViewModel()
        
        //Use this to manage navigation to the other screens
        /*
        viewModel.routePublisher
            .map{route -> BluetoothRoute in
                switch route{
                case .home:
                }
            }
            .assign(toSubject: navigationSubject)
            .store(in: &viewModel.cancellables)
        */
        let view = BluetoothView(viewModel: viewModel)
        let viewController = UIHostingHiddenNavBarController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
}
