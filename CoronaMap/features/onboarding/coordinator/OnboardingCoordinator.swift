//
//  OnboardingCoordinator.swift
//  CoronaMap
//
//  Created by Song on 07/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

protocol OnboardingCoordinatorDelegate: class {
    func onFinish()
}

class OnboardingCoordinator: Coordinator {

    weak var delegate: OnboardingCoordinatorDelegate?
    var window: UIWindow?

    init(window: UIWindow?, delegate: OnboardingCoordinatorDelegate?) {
        self.window = window
        self.delegate = delegate
    }

    func start() {
        guard let window = self.window else {
            return
        }

        let viewController = OnboardingViewController()
        viewController.coordinatorDelegate = delegate
        UIView.fadeInWindowCrossDissolveTransition(window: window, viewController: viewController)
    }

    func finish() {  }
}
