//
//  String+Extension.swift
//  CoronaMap
//
//  Created by Song on 06/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation

extension String {

    static var avenirNextRegular = "AvenirNext-Regular"
    static var avenirNextBold = "AvenirNext-Bold"
    static var avenirDemiBold = "AvenirNext-DemiBold"
    static var avenirNextMedium = "AvenirNext-Medium"

    static var onboardingKey = "onboardingKey"
}

extension UserDefaults {

    func isOnboardingDone() -> Bool {
        return self.integer(forKey: .onboardingKey) == 1
    }
}
