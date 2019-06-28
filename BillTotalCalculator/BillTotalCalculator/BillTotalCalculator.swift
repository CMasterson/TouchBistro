//
//  BillTotalCalculator.swift
//  BillTotalCalculator
//
//  Created by Conor Masterson on 2019-06-26.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import Foundation

public class BillTotalCalculator {
    
    /// Take a BillTotalInputModel and sum up the subtotal, apply discounts and taxes and return a BillTotalOutPutModel to that effect
    ///
    /// - Parameter input: A collection of items, taxes and discounts to calcualted
    /// - Returns: A model that represents the subtotal, discounts applied, taxes applied and the due amount
    public func calculateBill(input: BillTotalInputModel) -> BillTotalOutputModel {
        let subtotal = getSubtotal(input)
        let totalTaxes = getTotalTaxes(input)
        
        return BillTotalOutputModel(subtotal: subtotal, discounts: 0, tax: totalTaxes, total: 0)
    }
    
    /// Add up the bill items and return the total value, before tax and discounts
    ///
    /// - Parameter input: The BillTotalInputModel that represents all items on the current bill
    /// - Returns: The currency amount of all items on the bill, not including tax and discounts
    func getSubtotal(_ input: BillTotalInputModel) -> Float {
        var runningSubtotal: Float = 0
        
        input.billItems.forEach {
            runningSubtotal += $0.price
        }
        
        return runningSubtotal
    }
    
    /// Get the total value of discounts applied to a subtotal
    ///
    /// - Parameters:
    ///   - subtotal: The current subtotal from which to subtract discounts
    ///   - discounts: An ordered array of BillDiscount objects to apply
    /// - Returns: The currency value of discounts that have been applied (i.e. a 20% discount on a 100 subtotal returns 20)
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
    
    
    /// Get the total amount of tax owed on the given bill
    ///
    /// - Parameter input: A collection of items, taxes and discounts to be processed
    /// - Returns: The currency value for total taxes applied to the bill object
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
