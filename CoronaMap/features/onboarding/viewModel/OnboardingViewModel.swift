//
//  OnboardingViewModell.swift
//  CoronaMap
//
//  Created by Song on 08/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewModel {

    fileprivate let numberOfPages = 3

    fileprivate let imageConfig = UIImage.SymbolConfiguration(pointSize: 200, weight: .thin, scale: .large)

    func createPages() -> [UIViewController] {

        var viewControllers: [UIViewController] = []

        var pageContent: [OnboardingPageModel] = [
            OnboardingPageModel(
                image: UIImage(systemName: "exclamationmark.square", withConfiguration: imageConfig),
                content: "mapa.brazil.onboarding_text1".localized()),
            OnboardingPageModel(
                image: UIImage(systemName: "questionmark.square", withConfiguration: imageConfig),
                content: "mapa.brazil.onboarding_text2".localized()),
            OnboardingPageModel(
                image: UIImage(systemName: "checkmark.circle", withConfiguration: imageConfig),
                content: "mapa.brazil.onboarding_text3".localized())
        ]

        for item in (1...numberOfPages) {

            let content = pageContent.remove(at: item-1)
            pageContent.insert(content, at: item-1)

            let page = item == numberOfPages ?
                OnboardingPageViewController(pageType: .last, pageContent: content) :
                OnboardingPageViewController(pageType: .any, pageContent: content)

            page.view.backgroundColor = .systemIndigo
            viewControllers.append(page)
        }

        return viewControllers
    }
}
