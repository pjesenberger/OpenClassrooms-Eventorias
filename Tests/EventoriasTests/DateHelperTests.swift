//
//  DateHelperTests.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
@testable import Eventorias

class DateHelperTests: XCTestCase {
    
    func testFormatDate() {
        let result = DateHelper.formatDate("2025-12-25")
        XCTAssertEqual(result, "25 Dec 2025")
    }
    
    func testFormatTime() {
        let result = DateHelper.formatTime("14:30")
        XCTAssertEqual(result, "02:30 PM")
    }
    
    func testInvalidDateFormat() {
        let result = DateHelper.formatDate("invalid-date")
        XCTAssertEqual(result, "invalid-date")
    }
    
    func testInvalidTimeFormat() {
        let result = DateHelper.formatTime("invalid-time")
        XCTAssertEqual(result, "invalid-time")
    }
}
