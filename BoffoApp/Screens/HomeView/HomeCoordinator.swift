//
//  HomeCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit

enum HomeRoute{
    case home
    case pop
}

class HomeCoordinator: BABaseCoordinator<HomeRoute> {
    
    private let navigationSubject = BAPassthroughSubject<HomeRoute>()

    init(navigationController: UINavigationController = UINavigationController()) {
        super.init(navigationController: navigationController)
        navigationSubject.send(.home)
    }
    
    override func bindNavigation() {
        navigationSubject
            .sink {[weak self] route in
                switch route{
                case .home:
                    self?.showHome()
                case .pop:
                    self?.pop()
                }
            }
            .store(in: &cancellableBag)
    }
    
    private func showHome() {
        let viewModel = HomeViewModel()
        //Can manage sub page navition here
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingHiddenNavBarController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
}
