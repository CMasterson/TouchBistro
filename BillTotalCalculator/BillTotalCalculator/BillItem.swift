//
//  BillItem.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-25.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

protocol BillItem {
    var price: Float { get }
    var taxes: [Float] { get }
}
