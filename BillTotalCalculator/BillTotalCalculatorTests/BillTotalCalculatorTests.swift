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
        let subtotal: Float = 100
        let expectedDiscountAmount: Float = 75
        
        let discountAmount = billCalculator.getDiscount(subtotal: subtotal, discounts: [BillDiscount(value: 50, type: .amount), BillDiscount(value: 0.5, type: .percentile)])
        
        XCTAssert(discountAmount == expectedDiscountAmount)
    }
    
    func testBillDiscountOrder2() {
        let subtotal: Float = 100
        let expectedDiscountAmount: Float = 100
        
        let discountAmount = billCalculator.getDiscount(subtotal: subtotal, discounts: [BillDiscount(value: 0.5, type: .percentile), BillDiscount(value: 50, type: .amount)])
        
        XCTAssert(discountAmount == expectedDiscountAmount)
    }
    
    func testBillDiscountsNegativeValue() {
        let subtotal: Float = 100
        let expectedDiscountAmount: Float = 100
        
        let discountAmount = billCalculator.getDiscount(subtotal: subtotal, discounts: [BillDiscount(value: -0.5, type: .percentile), BillDiscount(value: -50, type: .amount)])
        
        XCTAssert(discountAmount == expectedDiscountAmount)
    }
    
    func testBillSubtotalSingleItem() {
        let expectedSubtotal: Float = 10
        
        let billItems = [MockBillItem(price: 10, taxes: [0.1])]
        let billInputModel = BillTotalInputModel(billItems: billItems)
        let subtotal = billCalculator.getSubtotal(billInputModel)
        
        XCTAssert(subtotal == expectedSubtotal)
    }
    
    func testBillSubtotalMultiItem() {
        let expectedSubtotal: Float = 100
        
        let billItems = [MockBillItem(price: 10, taxes: [0.1]), MockBillItem(price: 20, taxes: [0.1]), MockBillItem(price: 30, taxes: [0.1]), MockBillItem(price: 40, taxes: [0.1])]
        let billInputModel = BillTotalInputModel(billItems: billItems)
        let subtotal = billCalculator.getSubtotal(billInputModel)
        
        XCTAssert(subtotal == expectedSubtotal)
    }
    
    func testBillSubtotalMultiItemNegativeValue() {
        let expectedSubtotal: Float = 0
        
        let billItems = [MockBillItem(price: -10, taxes: [0.1]), MockBillItem(price: 20, taxes: [0.1]), MockBillItem(price: 30, taxes: [0.1]), MockBillItem(price: -40, taxes: [0.1])]
        let billInputModel = BillTotalInputModel(billItems: billItems)
        let subtotal = billCalculator.getSubtotal(billInputModel)
        
        XCTAssert(subtotal == expectedSubtotal)
    }

}
