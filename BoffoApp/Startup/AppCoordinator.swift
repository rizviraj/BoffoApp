//
//  AppCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Combine
import SwiftUI

enum AppInitialRoute {
    case tabBar
    case intro
}

final class AppCoordinator: BABaseCoordinator<AppInitialRoute> {

    private typealias Route = AppInitialRoute

    // MARK: - Private stored properties
    private let window: UIWindow
    private let navigationSubject = BAPassthroughSubject<Route>()
    private let notificationCenter: NotificationCenter
    private var deepLinksSubscription: AnyCancellable?

    // MARK: - Internal methods
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController(),
         notificationCenter: NotificationCenter = .default) {
        self.window = window
        self.notificationCenter = notificationCenter
        super.init(navigationController: navigationController)
        initialNavigation()
        notificationCenter.addObserver(self, selector: #selector(self.methodOfReceivedNotification),
                                       name: Notification.Name("LOGOUT"),
                                       object: nil)
    }

    override func bindNavigation() {
        navigationSubject
            .sink { [weak self] route in
                switch route {
                case .tabBar:
                    self?.switchToTabBar()
                case .intro:
                    self?.showIntroViews()
                }
            }
            .store(in: &cancellableBag)
 
    }

    // MARK: - Private methods
    private func initialNavigation() {
        //let initialRoute: Route = Application.shared.checkValidLogin() != true ? .intro : .tabBar
        let initialRoute: Route = .intro
        navigationSubject.send(initialRoute)
    }

    @objc func methodOfReceivedNotification() {
        self.clearTabBarCoordinator()
        self.navigationSubject.send(.intro)
    }

    private func showIntroViews() {
        let introCoordinator = LaunchCoordinator(window: window, navigationController: navigationController)
        
        introCoordinator.eventPublisher
            .map { event in
                switch event {
                case .showTab:
                    return .tabBar
                }
            }
            .assign(toSubject: navigationSubject)
            .store(in: &introCoordinator.cancellableBag)
         
        coordinate(to: introCoordinator)
    }
    
    private func switchToTabBar() {
        let tabbarCoordinator = TabbarCoordinator(window: window)
        coordinate(to: tabbarCoordinator)
    }
    
    private func clearTabBarCoordinator() {
        guard let tabbarCoordinator = childCoordinators.last(where: { $0 is TabbarCoordinator }) else { return }
        removeChildCoordinators(coordinator: tabbarCoordinator)
        didFinish(coordinator: tabbarCoordinator)
    }

    private func removeChildCoordinators(coordinator: Coordinator) {
        if let lastCoordinator = coordinator.childCoordinators.last {
            removeChildCoordinators(coordinator: lastCoordinator)
        } else if let parentCoordinator = coordinator.parentCoordinator {
            parentCoordinator.didFinish(coordinator: coordinator)
            removeChildCoordinators(coordinator: parentCoordinator)
        }
    }
    
}
