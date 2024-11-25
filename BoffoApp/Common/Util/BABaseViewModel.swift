//
//  BABaseViewModel.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine

class BABaseViewModel {

    // MARK: - Internal stored properties
    @Published var isAnimating = false
    @Published var errorMessage: String? = nil
    @Published var isShowContents: Bool = true


    // TODO: add loader, error tracker
    var cancellables = Set<AnyCancellable>()
    var refreshSubject = BAPassthroughSubject<Void>()

    // MARK: - Internal methods
    init() {
        bind()
    }

    func bind() {
        // TODO: add error tracker, loader etc binding methods
    }
    
    deinit {
        print("\(self): Deinited")
    }
}
