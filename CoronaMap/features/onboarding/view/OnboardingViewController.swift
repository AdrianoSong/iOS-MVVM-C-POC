//
//  OnboardingViewController.swift
//  CoronaMap
//
//  Created by Song on 07/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewController: UIPageViewController {

    fileprivate var pages = [UIViewController]()

    weak var coordinatorDelegate: OnboardingCoordinatorDelegate?

    fileprivate var viewModel: OnboardingViewModel

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil) {

        viewModel = OnboardingViewModel()

        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: options)

        configPageIndicatorSyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        defineOnboardingPages()

        defineDelegates()

        defineFirstVCPassToPageControl()
    }

    fileprivate func defineOnboardingPages() {
        for item in viewModel.createPages() {
            if let teste = item as? OnboardingPageViewController {
                teste.finish = { [weak self] in
                    self?.coordinatorDelegate?.onFinish()
                }
                pages.append(teste)

            } else {
                pages.append(item)
            }
        }
    }

    fileprivate func configPageIndicatorSyle() {
        let pageControl: UIPageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .white
        pageControl.backgroundColor = .systemIndigo
    }

    fileprivate func defineDelegates() {
        self.dataSource = self
    }

    fileprivate func defineFirstVCPassToPageControl() {
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            view.backgroundColor = viewController.view.backgroundColor
            return nil
        }

        return pages[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else {
            view.backgroundColor = viewController.view.backgroundColor
            return nil
        }

        return pages[nextIndex]
    }
}
