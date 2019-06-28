//
//  BillTotalInputModel.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillTotalInputModel {
    let billItems: [BillItem]
    let discounts: [BillDiscount]?
    
    init(billItems: [BillItem], discounts: [BillDiscount]? = nil) {
        self.billItems = billItems
        self.discounts = discounts
    }
}
