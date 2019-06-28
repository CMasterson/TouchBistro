//
//  MockBillItem.swift
//  BillTotalCalculatorTests
//
//  Created by Conor Masterson on 2019-06-27.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation
@testable import BillTotalCalculator

class MockBillItem: BillItem {
    var price: Float
    var taxes: [Float]
    
    init(price: Float, taxes: [Float]) {
        self.price = price
        self.taxes = taxes
    }
}
