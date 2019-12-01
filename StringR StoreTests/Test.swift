//
//  StringR_StoreTests.swift
//  StringR StoreTests
//
//  Created by Jaafar on 29/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import XCTest
@testable import StringR_Store

class Test: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let exp = 2
        let actual = 2

        assert(exp == actual)
    }

    func testUtilityString() {
        let string = Utility.getString(forKey: "common_ok")
        XCTAssertEqual("Okay", string)
    }
}
