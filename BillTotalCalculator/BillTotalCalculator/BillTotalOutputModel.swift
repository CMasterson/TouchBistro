//
//  BillTotalOutputModel.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillTotalOutputModel {
    public let subtotal: Float
    public let discounts: Float
    public let tax: Float
    public let total: Float
    
    init(subtotal: Float, discounts: Float, tax: Float) {
        self.subtotal = subtotal
        self.discounts = discounts
        self.tax = tax
        self.total = subtotal - discounts + tax
    }
}
