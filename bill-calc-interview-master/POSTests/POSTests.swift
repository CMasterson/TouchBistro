//
//  POSTests.swift
//  POSTests
//
//  Created by Tayson Nguyen on 2019-04-23.
//  Copyright © 2019 TouchBistro. All rights reserved.
//

import XCTest
@testable import POS

class POSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        taxes = [Tax(label: "One", amount: 1, isEnabled: true), Tax(label: "Two", amount: 2, isEnabled: false), Tax(label: "Three", amount: 3, isEnabled: true)]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTaxViewModelTitle() {
        let expectedResult = "Taxes"
        let instance = TaxViewModel()
        for (index, _) in taxes.enumerated() {
            XCTAssert(instance.title(for: index) == expectedResult)
        }
    }
    
    func testTaxViewModelNumSections() {
        let expectedResult = 1
        let instance = TaxViewModel()
        
        XCTAssert(instance.numberOfSections() == expectedResult)
    }
    
    func testTaxViewModelNumRows() {
        let expectedResult = taxes.count
        let instance = TaxViewModel()
        
        XCTAssert(instance.numberOfRows(in: 0) == expectedResult)
    }
    
    func testTaxViewModelLabel() {
        let expectedResult = ["One", "Two", "Three"]
        let instance = TaxViewModel()
        
        for (index, _) in taxes.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            XCTAssert(instance.labelForTax(at: indexPath) == expectedResult[index])
        }
    }
    
    func testTaxViewModelAccessoryType() {
        let expectedResult: [UITableViewCell.AccessoryType] = [.checkmark, .none, .checkmark]
        let instance = TaxViewModel()
        
        for (index, _) in taxes.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            XCTAssert(instance.accessoryType(at: indexPath) == expectedResult[index])
        }
    }
    
    func testTaxViewModelToggle() {
        let expectedResultPreChange = [true, false, true]
        let expectedResultPostChange = [false, true, true]
        let instance = TaxViewModel()
        
        for (index, tax) in taxes.enumerated() {
            XCTAssert(tax.isEnabled == expectedResultPreChange[index], "testTaxViewModelToggle PreChange test data is incorrect")
        }
        
        instance.toggleTax(at: IndexPath(row: 0, section: 0))
        instance.toggleTax(at: IndexPath(row: 1, section: 0))
        
        for (index, tax) in taxes.enumerated() {
            XCTAssert(tax.isEnabled == expectedResultPostChange[index])
        }
    }
    
    func testFormatNumber() {
        let rvc = RegisterViewController(nibName: nil, bundle: nil)
        let expectedResult = "$1,000.99"
        let actualNumber = rvc.viewModel.formatNumber(1000.99)
        
        XCTAssert(actualNumber == expectedResult)
    }
    
    func testFormatNumberNil() {
        let rvc = RegisterViewController(nibName: nil, bundle: nil)
        let expectedResult: String = ""
        let actualNumber = rvc.viewModel.formatNumber(nil)
        
        XCTAssert(actualNumber == expectedResult)
    }

}
