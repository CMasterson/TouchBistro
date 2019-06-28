//
//  BillTotalOutputModel.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillTotalOutputModel {
    let subtotal: String
    let discounts: String
    let tax: String
    let total: String
    
    init(subtotal: String, discounts: String, tax: String, total: String) {
        self.subtotal = subtotal
        self.discounts = discounts
        self.tax = tax
        self.total = total
    }
    
    init(subtotal: Float, discounts: Float, tax: Float, total: Float) {
        self.subtotal = "subtotal"
        self.discounts = "discounts"
        self.tax = "tax"
        self.total = "total"
    }
}
