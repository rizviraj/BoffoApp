//
//  LaunchViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine

final class LaunchViewModel: ObservableObject {
    
    enum Route{
        case showLogin
    }
    
    // MARK: - Internal computed properties
    var routePublisher: BAAnyPublisher<Route> {
        routeSubject.eraseToAnyPublisher()
    }
    
    var routeSubject = BAPassthroughSubject<Route>()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){[weak self] in
            self?.routeSubject.send(.showLogin)
        }
    }
   
}
