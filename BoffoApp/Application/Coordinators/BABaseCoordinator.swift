//
//  BABaseCoordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import UIKit
import Combine

class BABaseCoordinator<RouteType>: NSObject, Coordinator {

    // MARK: - Internal stored properties
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var cancellableBag = CancellableBag()
    let initialRoute: RouteType?

    // MARK: - Internal methods
    init(navigationController: UINavigationController,
         initialRoute: RouteType? = nil) {
        self.navigationController = navigationController
        self.initialRoute = initialRoute
        super.init()
        self.hideNavigationBarBackgroundAndShadow()
        bindNavigation()
    }

    func start() { }
    func bindNavigation() { }

    // MARK: - Private methods
    private func hideNavigationBarBackgroundAndShadow() {
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
