//
//  BillDiscount.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public enum DiscountType {
    case percentile
    case amount
}

public class BillDiscount {
    let value: Float
    let type: DiscountType
    
    public init(value: Float, type: DiscountType) {
        self.value = value
        self.type = type
    }
}
