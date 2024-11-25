//
//  LaunchCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import SwiftUI

enum IntroViewRoute {
    case launch
    case login
    case showTab
    case pop
}

class LaunchCoordinator: BABaseCoordinator<IntroViewRoute> {
    
    enum Event{
        case showTab
    }
    // MARK: - Private stored properties
    private let navigationSubject = BAPassthroughSubject<IntroViewRoute>()
    private let window: UIWindow
    
    var eventPublisher: BAAnyPublisher<Event>{
        return eventSubject.eraseToAnyPublisher()
    }
    private let eventSubject = BAPassthroughSubject<Event>()
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        super.init(navigationController: navigationController)
        
        navigationSubject.send(.launch)
    }
    
    override func bindNavigation() {
        navigationSubject.sink { [weak self] route in
            switch route {
            case .login: self?.showLoginView()
            case .launch: self?.showLaunchView()
            //case .otp: self?.showOTPView()
            case .showTab: self?.showTab()
            case .pop: self?.pop()
            }
        }
        .store(in: &cancellableBag)
    }
    
    // MARK: - Private methods
    private func showLaunchView() {
        let viewModel = LaunchViewModel()
        
        viewModel.routePublisher
            .map { route -> IntroViewRoute in
                switch route {
                case .showLogin:
                    return .login
                }
            }
            .assign(toSubject: navigationSubject)
            .store(in: &viewModel.cancellables)
         
        let view = LaunchView(viewModel: viewModel)
        let viewController = UIHostingHiddenNavBarController(rootView: view)
        launchFirstController(viewController: viewController)
    }
    
    // MARK: - Private methods login
    private func showLoginView() {
        let viewModel = LoginViewModel()
        
        viewModel.routePublisher
            .map { route -> IntroViewRoute in
                switch route {
                case .loginSuccess:
                    return .showTab
                }
            }
            .assign(toSubject: navigationSubject)
            .store(in: &viewModel.cancellables)
         
        let view = LoginView(viewModel: viewModel)
        let viewController = UIHostingHiddenNavBarController(rootView: view)
        launchFirstController(viewController: viewController)
    }

    private func showTab() {
        eventSubject.send(.showTab)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
    
    private func launchFirstController(viewController: UIViewController, completion: @escaping () -> Void = {}) {
        navigationController.pushViewController(viewController, animated: true)
        window.rootViewController = navigationController
    }
}
