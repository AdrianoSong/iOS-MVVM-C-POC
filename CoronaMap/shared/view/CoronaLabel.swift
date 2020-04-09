//
//  CoronaLabel.swift
//  CoronaMap
//
//  Created by Song on 07/04/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class CoronaLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func layout() {
        alpha = 0
        textColor = .black
        font = UIFont(name: .avenirNextRegular, size: 18)
        numberOfLines = 0
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
