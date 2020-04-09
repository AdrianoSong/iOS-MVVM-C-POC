//
//  OnboardingPage.swift
//  CoronaMap
//
//  Created by Song on 07/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

enum OnboardingPageType {
    case last
    case any
}

class OnboardingPageViewController: UIViewController {

    fileprivate var pageType: OnboardingPageType
    fileprivate var pageContent: OnboardingPageModel?

    var finish: (() -> Void)?

    fileprivate let pageTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    fileprivate let finishButton: UIButton = {
        let view = UIButton()
        view.setTitle("mapa.brazil.onboarding_finish".localized(), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate let pageImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init() {
        self.init(pageType: .any, pageContent: nil)
    }

    init(pageType: OnboardingPageType, pageContent: OnboardingPageModel?) {
        self.pageType = pageType
        self.pageContent = pageContent
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        prepareForAnimate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        enterAnimation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        prepareForAnimate()
    }

    fileprivate func layout() {
        setupPageTitle()
        setupFinishButton()
        setupPageImage()
    }

    fileprivate func setupPageTitle() {
        view.addSubview(pageTitle)

        pageTitle.centerYAnchor.constraint(
            equalTo: customLayoutGuide.centerYAnchor, constant: 100).isActive = true
        pageTitle.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor, constant: 20).isActive = true
        pageTitle.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor, constant: -20).isActive = true

        pageTitle.text = pageContent?.content
    }

    fileprivate func setupFinishButton() {
        view.addSubview(finishButton)

        finishButton.topAnchor.constraint(
            equalTo: customLayoutGuide.topAnchor, constant: 20).isActive = true
        finishButton.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor, constant: -20).isActive = true

        finishButton.addTarget(self, action: #selector(didFinishTap), for: .touchUpInside)

        finishButton.isHidden = pageType == .last ? false : true
    }

    fileprivate func setupPageImage() {
        view.addSubview(pageImage)

        pageImage.bottomAnchor.constraint(
            equalTo: pageTitle.topAnchor, constant: -40).isActive = true
        pageImage.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor, constant: 20).isActive = true
        pageImage.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor, constant: -20).isActive = true

        pageImage.image = pageContent?.image?.withRenderingMode(.alwaysTemplate)
        pageImage.tintColor = .white
    }

    @objc
    fileprivate func didFinishTap() {
        finish?()
    }

    fileprivate func prepareForAnimate() {
        pageTitle.transform = CGAffineTransform(translationX: 0, y: 20)
        pageTitle.alpha = 0

        finishButton.alpha = 0

        pageImage.transform = CGAffineTransform(translationX: 0, y: 20)
        pageImage.alpha = 0
    }

    fileprivate func enterAnimation() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.pageTitle.alpha = 1
            self?.pageTitle.transform = CGAffineTransform(translationX: 0, y: -20)

            self?.finishButton.alpha = 1

            self?.pageImage.transform = CGAffineTransform(translationX: 0, y: -20)
            self?.pageImage.alpha = 1
        })
    }
}
