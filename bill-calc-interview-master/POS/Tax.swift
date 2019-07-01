//
//  Tax.swift
//  POS
//
//  Created by Conor Masterson on 2019-06-30.
//  Copyright © 2019 TouchBistro. All rights reserved.
//

import Foundation

class Tax {
    let label: String
    let amount: Float
    var isEnabled: Bool
    
    init(label: String, amount: Float, isEnabled: Bool) {
        self.label = label
        self.amount = amount
        self.isEnabled = isEnabled
    }
}
