//
//  BillTotalCalculator.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillTotalCalculator {
    public func calculateBill(input: BillTotalInputModel) -> BillTotalOutputModel {
        let subtotal = getSubtotal(input)
        let totalTaxes = getTotalTaxes(input)
        
        return BillTotalOutputModel(subtotal: subtotal, discounts: 0, tax: totalTaxes, total: 0)
    }
    
    func getSubtotal(_ input: BillTotalInputModel) -> Float {
        var runningSubtotal: Float = 0
        
        input.billItems.forEach {
            runningSubtotal += $0.price
        }
        
        return runningSubtotal
    }
    
    func getDiscount(subtotal: Float, discounts: [BillDiscount]) -> Float {
        var runningTotal: Float = 0
        var modifiedSubtotal = subtotal
        
        discounts.forEach {
            let discountValue = $0.value.magnitude
            
            if $0.type == .amount {
                var discountedAmount: Float = 0
                
                if discountValue > modifiedSubtotal {
                    discountedAmount = modifiedSubtotal
                    modifiedSubtotal = 0
                } else {
                    discountedAmount = discountValue
                    modifiedSubtotal -= discountedAmount
                }
                
                runningTotal += discountedAmount
                
            } else {
                let discountedAmount = modifiedSubtotal * discountValue
                runningTotal += discountedAmount
                modifiedSubtotal -= discountedAmount
            }
        }
        
        return runningTotal
    }
    
    func getTotalTaxes(_ input: BillTotalInputModel) -> Float {
        var runningTotal: Float = 0
        
        input.billItems.forEach { (item) in
            item.taxes.forEach { (taxRate) in
                runningTotal += item.price * taxRate
            }
        }
        
        return runningTotal
    }
}
