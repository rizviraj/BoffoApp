//
//  TabbarCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

//import Foundation
import UIKit
import Combine

class TabbarCoordinator: Coordinator {

    // MARK: - Internal stored properties
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    let navigationController: UINavigationController
    let tabbarController: UITabBarController
    var cancelable: [AnyCancellable] = []

    // MARK: - Private stored properties
    private weak var window: UIWindow?

    // MARK: - Internal methods
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.tabbarController = UITabBarController()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.blue
        //appearance.stackedLayoutAppearance.normal.iconColor = UIColor.secondary
        //appearance.shadowImage = UIImage.navbarDivider(color: .secondary)
        tabbarController.tabBar.standardAppearance = appearance
        tabbarController.tabBar.isTranslucent = true
        tabbarController.tabBar.backgroundColor = UIColor(hex: "EEEEEE")
    }

    func start() {
        let controllers = createControllers()
        
        let coordinators = createCoordinators(controllers: controllers,
                                              tabBarNavigationController: navigationController)
        navigationController.viewControllers = [tabbarController]
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController

        self.tabbarController.viewControllers = controllers
        coordinators.enumerated().forEach {
            self.coordinate(to: $0.element)
        }
        self.tabbarController.selectedIndex = 0
        bindTabBar()
    }

    // MARK: - Private methods
    private func createControllers() -> [UINavigationController] {
        //Tab.allCases.map { tab -> UINavigationController in
        TabItems.allTabs.map { tab -> UINavigationController in
            createController(for: tab)
        }
    }
    
    private func bindTabBar() {
        
        Globals.shared.hideTabbar
            .sink {[weak self] status in
                DispatchQueue.main.async {[weak self] in
                    self?.tabbarController.tabBar.isHidden = status ? true : false
                    self?.tabbarController.tabBar.isTranslucent = status ? true : false
                }
            }
            .store(in: &cancelable)
    }
    
// MARK: - Create tab bar coordinator
    private func createCoordinators(controllers: [UINavigationController],
                                    tabBarNavigationController: UINavigationController) -> [Coordinator] {
        let allTabs = TabItems.allTabs
        return allTabs
            .compactMap { tab -> Coordinator? in
                guard let index = allTabs.firstIndex(of: tab) else { return nil }
                switch tab {
                case .home:
                    return HomeCoordinator(navigationController: controllers[index])
                case .bluetooth:
                    return BluetoothCoordinator(navigationController: controllers[index])
                case .wifi:
                    return WifiCoordinator(navigationController: controllers[index])
                case .tcp:
                    return TCPCoordinator(navigationController: controllers[index])
                }
            }
    }

    //MARK: - Create tab bar controller
    private func createController(for tab: TabItems) -> UINavigationController {
        //let defaultImage = UIImage(named: tab.tabImage)
        //let selectedImage = UIImage(named: tab.tabImageSelected)
        let tabBarItem = UITabBarItem(title: tab.tabName,
                                      image: tab.tabImage,
                                      selectedImage: tab.tabImageSelected)
        let navigationController = UINavigationController()
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}

