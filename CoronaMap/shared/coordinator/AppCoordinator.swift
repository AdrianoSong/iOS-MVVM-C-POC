//
//  Coordinator.swift
//  CoronaMap
//
//  Created by Adriano Song on 4/2/20.
//
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {

        if UserDefaults.standard.isOnboardingDone() {
            presentHome()
        } else {
            presentOnboarding()
        }
    }

    func finish() {}

    fileprivate func presentHome() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
    }

    fileprivate func presentOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(window: window, delegate: self)
        onboardingCoordinator.start()
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {

    func onFinish() {
        UserDefaults.standard.set(true, forKey: .onboardingKey)

        presentHome()
    }
}
