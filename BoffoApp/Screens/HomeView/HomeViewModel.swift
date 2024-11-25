//
//  HomeViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine

final class HomeViewModel: BABaseViewModel, ObservableObject{
    
    enum Route{
        //case pop
    }
    // MARK: - Internal computed properties
    var routePublisher: BAAnyPublisher<Route> {
        routeSubject.eraseToAnyPublisher()
    }
    private var routeSubject = BAPassthroughSubject<Route>()
    
    
    override func bind() {
        
  
    }

}
