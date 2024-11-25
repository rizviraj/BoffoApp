//
//  UIHostingHiddenNavBarController.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Combine
import Foundation
import SwiftUI

open class UIHostingHiddenNavBarController<T: View>: UIHostingController<T> {

    // MARK: - Internal computed properties
    public override var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    public override var prefersStatusBarHidden: Bool { hideStatusBar }

    // MARK: - Internal stored properties
    let viewWillAppearSubject = BAPassthroughSubject<Void>()
    let viewWillDisappearSubject = BAPassthroughSubject<Void>()
    let willRemoveFromParentSubject = BAPassthroughSubject<Void>()

    // MARK: - Private stored properties
    private var statusBarStyle: UIStatusBarStyle
    private let supportedOrientations: UIInterfaceOrientationMask
    private let hideStatusBar: Bool

    // MARK: - Public methods
    public init(rootView: T,
                statusBarStyle: UIStatusBarStyle = .lightContent,
                statusBarHidden: Bool = false,
                supportedInterfaceOrientations: UIInterfaceOrientationMask = .portrait) {
        self.statusBarStyle = statusBarStyle
        self.supportedOrientations = supportedInterfaceOrientations
        self.hideStatusBar = statusBarHidden
        super.init(rootView: rootView)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Backup line for hiding navigation bar
        hideNavigationBar()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        hideNavigationBar()
        viewWillAppearSubject.send()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            willRemoveFromParentSubject.send()
        }
        viewWillDisappearSubject.send()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if #available(iOS 15.0, *) {
            view.setNeedsUpdateConstraints()
        }
    }

    // MARK: - Internal methods
    @objc required dynamic public init?(coder: NSCoder) { nil }

    // MARK: - Private methods
    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
