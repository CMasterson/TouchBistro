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
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
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
