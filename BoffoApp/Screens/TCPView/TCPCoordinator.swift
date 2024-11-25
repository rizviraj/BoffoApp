//
//  TCPCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit

enum TCPRoute{
    case tcp
    case pop
}

class TCPCoordinator: BABaseCoordinator<TCPRoute> {
    
    private let navigationSubject = BAPassthroughSubject<TCPRoute>()

    init(navigationController: UINavigationController = UINavigationController()) {
        super.init(navigationController: navigationController)
        navigationSubject.send(.tcp)
    }
    
    override func bindNavigation() {
        navigationSubject
            .sink {[weak self] route in
                switch route{
                case .tcp:
                    self?.showTCP()
                case .pop:
                    self?.pop()
                }
            }
            .store(in: &cancellableBag)
    }
    
    private func showTCP() {
        let viewModel = TCPViewModel()
        //Todo - Manage sub page navition here
        let view = TCPView(viewModel: viewModel)
        let viewController = UIHostingHiddenNavBarController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
}
