//
//  BillTotalOutputModel.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillTotalOutputModel {
    let subtotal: Float
    let discounts: Float
    let tax: Float
    let total: Float
    
    init(subtotal: Float, discounts: Float, tax: Float) {
        self.subtotal = subtotal
        self.discounts = discounts
        self.tax = tax
        self.total = subtotal - discounts + tax
    }
}
