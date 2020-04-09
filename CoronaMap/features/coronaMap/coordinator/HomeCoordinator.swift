//
//  HomeCoordinator.swift
//  CoronaMap
//
//  Created by Song on 07/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {

    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        guard let window = self.window else {
            return
        }

        let viewController = ViewController()
        UIView.fadeInWindowCrossDissolveTransition(window: window, viewController: viewController)
    }

    func finish() {  }
}
