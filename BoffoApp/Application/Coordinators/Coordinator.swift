//
//  Coordinator.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Combine
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    func start()
    func coordinate(to coordinator: Coordinator)
    func store(coordinator: Coordinator)
    func resetNavigationStack()
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        store(coordinator: coordinator)
        coordinator.start()
    }

    func store(coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
    }

    func resetNavigationStack() {
        if let lastController = navigationController.viewControllers.last,
           let presentedVC = lastController.presentedViewController {
            lastController.dismiss(animated: false, completion: nil)
            presentedVC.dismiss(animated: false, completion: nil)
        }
        navigationController.popToRootViewController(animated: false)
        childCoordinators.removeAll()
    }

    func didFinish(coordinator: Coordinator) {
        guard let index = (childCoordinators.lastIndex { $0 === coordinator }) else { return }
        childCoordinators.remove(at: index)
    }

    func findParentCoordinator<T: Coordinator>(ofType coordinatorType: T.Type) -> T? {
        if let parentCoordinator = parentCoordinator {
            if type(of: parentCoordinator) == coordinatorType {
                return parentCoordinator as? T
            } else {
                return parentCoordinator.findParentCoordinator(ofType: coordinatorType)
            }
        } else {
            return nil
        }
    }
}
