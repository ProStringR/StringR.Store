//
//  UtilityTest.swift
//  StringR StoreTests
//
//  Created by Jaafar on 01/12/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import XCTest
@testable import ProStringR_Store

class UtilityTest: XCTestCase {

    func testUtilityString() {
        let string = Utility.getString(forKey: "common_ok")
        XCTAssertEqual("Okay", string)
    }

    func testDateConverter() {
        let date = Utility.dateToString(date: Date.init(milliseconds: 708696930000), withTime: false)
        XCTAssertEqual("16/06/1992", date)
    }

    func testDateTimeConverter() {
        let dateAndTime = Utility.dateToString(date: Date.init(milliseconds: 708696930000))
        XCTAssertEqual("16/06/1992 | 14:15", dateAndTime)
    }
}
