//
//  BillTotalCalculatorTests.swift
//  BillTotalCalculatorTests
//
//  Created by Conor Masterson on 2019-06-25.
//  Copyright © 2019 Conor Masterson. All rights reserved.
//

import XCTest
@testable import BillTotalCalculator

class BillTotalCalculatorTests: XCTestCase {

    var billCalculator = BillTotalCalculator()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        billCalculator = BillTotalCalculator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testBillDiscountOrder1() {
        let itemValue: Float = 100
        let expectedDiscountAmount: Float = 45
        
        let discountAmount = billCalculator.apply([0.5, 0.1], to: itemValue)
        
        XCTAssert(discountAmount == expectedDiscountAmount)
    }
    
    func testBillDiscountOrder2() {
        let itemValue: Float = 100
        let expectedDiscountAmount: Float = 45
        
        let discountAmount = billCalculator.apply([0.1, 0.5], to: itemValue)
        
        XCTAssert(discountAmount == expectedDiscountAmount)
    }
    
    func testBillSubtotalSingleItem() {
        let expectedSubtotal: Float = 10
        
        let billItems = [BillItem(price: 10, taxes: [0.1])]
        let billInputModel = BillTotalInputModel(billItems: billItems)
        let subtotal = billCalculator.getSubtotal(billInputModel)
        
        XCTAssert(subtotal == expectedSubtotal)
    }
    
    func testBillSubtotalMultiItem() {
        let expectedSubtotal: Float = 100
        
        let billItems = [BillItem(price: 10, taxes: [0.1]), BillItem(price: 20, taxes: [0.1]), BillItem(price: 30, taxes: [0.1]), BillItem(price: 40, taxes: [0.1])]
        let billInputModel = BillTotalInputModel(billItems: billItems)
        let subtotal = billCalculator.getSubtotal(billInputModel)
        
        XCTAssert(subtotal == expectedSubtotal)
    }
    
    func testBillSubtotalMultiItemNegativeValue() {
        let expectedSubtotal: Float = 0
        
        let billItems = [BillItem(price: -10, taxes: [0.1]), BillItem(price: 20, taxes: [0.1]), BillItem(price: 30, taxes: [0.1]), BillItem(price: -40, taxes: [0.1])]
        let billInputModel = BillTotalInputModel(billItems: billItems)
        let subtotal = billCalculator.getSubtotal(billInputModel)
        
        XCTAssert(subtotal == expectedSubtotal)
    }
    
    func testConvertDiscount1() {
        let givenSubtotal: Float = 100
        let expectedResult: [Float] = [0.1, 0.1]
        
        let discounts = [BillDiscount(value: 10, type: .amount), BillDiscount(value: 0.1, type: .percentile)]
        
        let actualResult = billCalculator.convertDiscountsToPercent(subtotal: givenSubtotal, discounts: discounts)
        
        XCTAssert(actualResult == expectedResult)
    }
    
    func testConvertDiscount2() {
        let givenSubtotal: Float = 100
        let expectedResult: [Float] = [0.1, 0.1]
        
        let discounts = [BillDiscount(value: 0.1, type: .percentile), BillDiscount(value: 9, type: .amount)]
        
        let actualResult = billCalculator.convertDiscountsToPercent(subtotal: givenSubtotal, discounts: discounts)
        
        XCTAssert(actualResult == expectedResult)
    }
    
    func testConvertExcessiveDiscount() {
        let givenSubtotal: Float = 100
        let expectedResult: [Float] = [1]
        
        let discounts = [BillDiscount(value: 200, type: .amount), BillDiscount(value: 0.1, type: .percentile)]
        
        let actualResult = billCalculator.convertDiscountsToPercent(subtotal: givenSubtotal, discounts: discounts)
        
        XCTAssert(actualResult == expectedResult)
    }
    
    func testTaxes() {
        let billItems = [BillItem(price: 10, taxes: [0.1, 0.1]), BillItem(price: 10, taxes: [0.5, 0.5])]
        let modifiedPrices: [Float] = [10, 10]
        let expectedResult: Float = 12
        
        let actualResult = billCalculator.getTotalTaxes(for: billItems, with: modifiedPrices)
        
        XCTAssert(actualResult == expectedResult)
    }

}
