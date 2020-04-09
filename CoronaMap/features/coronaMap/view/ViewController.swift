//
//  ViewController.swift
//  CoronaMap
//
//  Created by Song on 06/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = VCViewModel()

    fileprivate let screenTitle: CoronaLabel = {
    	let view = CoronaLabel()
        view.alpha = 1
        view.font = UIFont(name: .avenirNextMedium, size: 32)
    	return view
    }()

    fileprivate let screenDescription: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .blue
        return view
    }()

    fileprivate let labelTested: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .gray
        return view
    }()

    fileprivate let labelRecovered: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .systemGreen
        return view
    }()

    fileprivate let labelInfected: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .orange
        view.font = UIFont(name: .avenirNextRegular, size: 24)
        return view
    }()

    fileprivate let labelDeceased: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .red
        view.font = UIFont(name: .avenirNextRegular, size: 32)
        return view
    }()

    fileprivate let screenStateTitle: CoronaLabel = {
        let view = CoronaLabel()
        view.alpha = 1
        view.font = UIFont(name: .avenirNextMedium, size: 32)
        return view
    }()

    fileprivate let labelInfectedByState: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .orange
        view.font = UIFont(name: .avenirNextRegular, size: 32)
        return view
    }()

    fileprivate let labelDeceasedByState: CoronaLabel = {
        let view = CoronaLabel()
        view.textColor = .red
        view.font = UIFont(name: .avenirNextRegular, size: 32)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()

        getAllBrazilData()
    }

    fileprivate func layout() {

        setupScreenTitle()
        setupScreenDescription()
        setupLabelTested()
        setupLabelRecovered()
        setupLabelInfected()
        setupLabelDecesead()
        setupScreenStateTitle()
        setupLabelInfectedByState()
        setupLabelDeceasedByState()
    }

    fileprivate func setupScreenTitle() {
        view.addSubview(screenTitle)

        screenTitle.topAnchor.constraint(
            equalTo: customLayoutGuide.topAnchor, constant: 16).isActive = true
        screenTitle.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        screenTitle.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true

        screenTitle.text = viewModel.screenTitle()
    }

    fileprivate func setupScreenDescription() {
        view.addSubview(screenDescription)

        screenDescription.topAnchor.constraint(
            equalTo: screenTitle.bottomAnchor, constant: 4).isActive = true
        screenDescription.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        screenDescription.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupLabelTested() {
        view.addSubview(labelTested)

        labelTested.topAnchor.constraint(
            equalTo: screenDescription.bottomAnchor, constant: 4).isActive = true
        labelTested.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        labelTested.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupLabelRecovered() {
        view.addSubview(labelRecovered)

        labelRecovered.topAnchor.constraint(
            equalTo: labelTested.bottomAnchor, constant: 4).isActive = true
        labelRecovered.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        labelRecovered.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupLabelInfected() {
        view.addSubview(labelInfected)

        labelInfected.topAnchor.constraint(
            equalTo: labelRecovered.bottomAnchor, constant: 4).isActive = true
        labelInfected.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        labelInfected.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupLabelDecesead() {
        view.addSubview(labelDeceased)

        labelDeceased.topAnchor.constraint(
            equalTo: labelInfected.bottomAnchor, constant: 4).isActive = true
        labelDeceased.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        labelDeceased.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupScreenStateTitle() {
        view.addSubview(screenStateTitle)

        screenStateTitle.topAnchor.constraint(
            equalTo: labelDeceased.bottomAnchor, constant: 16).isActive = true
        screenStateTitle.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        screenStateTitle.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupLabelInfectedByState() {
        view.addSubview(labelInfectedByState)

        labelInfectedByState.topAnchor.constraint(
            equalTo: screenStateTitle.bottomAnchor, constant: 4).isActive = true
        labelInfectedByState.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        labelInfectedByState.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func setupLabelDeceasedByState() {
        view.addSubview(labelDeceasedByState)

        labelDeceasedByState.topAnchor.constraint(
            equalTo: labelInfectedByState.bottomAnchor, constant: 4).isActive = true
        labelDeceasedByState.leadingAnchor.constraint(
            equalTo: customLayoutGuide.leadingAnchor).isActive = true
        labelDeceasedByState.trailingAnchor.constraint(
            equalTo: customLayoutGuide.trailingAnchor).isActive = true
    }

    fileprivate func getAllBrazilData() {
        viewModel.getAllBrazilCoronaData()
            .subscribe(onNext: { [weak self] coronaData in

                self?.viewModel.tryToReachLocation(completion: { state in
                    self?.setAllBrazilData(coronaData: coronaData, state: state)

                    self?.fadeInData()
                })

            }, onError: { error in
                print("my error \(error)")
            }, onCompleted: nil)
            .disposed(by: viewModel.bad)
    }

    fileprivate func setAllBrazilData(coronaData: Corona, state: String) {

        let infectedByState = coronaData.infectedByRegion?.first { $0.state == state }?.count
        let deceasedByState = coronaData.deceasedByRegion?.first { $0.state == state }?.count

        screenDescription.text = viewModel.screenDescription(
            timeStamp: coronaData.lastUpdatedAtApify)
        labelTested.text = viewModel.convertInfo(
            phrase: "mapa.brazil.tested".localized(), data: coronaData.tested)
        labelRecovered.text = viewModel.convertInfo(
            phrase: "mapa.brazil.recovered".localized(), data: coronaData.recovered)
        labelInfected.text = viewModel.convertInfo(
            phrase: "mapa.brazil.infected".localized(), data: coronaData.infected)
        labelDeceased.text = viewModel.convertInfo(
            phrase: "mapa.brazil.deceased".localized(), data: coronaData.deceased)
        screenStateTitle.text = viewModel.screenStateTitle(state: state)
        labelInfectedByState.text = viewModel.convertInfo(
            phrase: "mapa.brazil.infected".localized(), data: infectedByState)
        labelDeceasedByState.text = viewModel.convertInfo(
            phrase: "mapa.brazil.deceased".localized(), data: deceasedByState)
    }

    fileprivate func fadeInData() {
        UIView.fadeInAnimation(view: screenDescription)
        UIView.fadeInAnimation(view: labelTested)
        UIView.fadeInAnimation(view: labelRecovered)
        UIView.fadeInAnimation(view: labelInfected)
        UIView.fadeInAnimation(view: labelDeceased)
        UIView.fadeInAnimation(view: labelInfectedByState)
        UIView.fadeInAnimation(view: labelDeceasedByState)
    }
}
