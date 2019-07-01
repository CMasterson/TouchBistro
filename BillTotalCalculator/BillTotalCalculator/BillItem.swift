//
//  BillItem.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-25.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillItem {
    let price: Float
    let taxes: [Float]
    
    public init(price: Float, taxes: [Float]) {
        self.price = price
        self.taxes = taxes
    }
}
