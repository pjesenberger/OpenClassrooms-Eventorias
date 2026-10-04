//
//  EventoriasUITests.swift
//  EventoriasUITests
//
//  Created by Pascal Jesenberger on 18/09/2025.
//

import XCTest

final class EventoriasUITests: XCTestCase {

    @MainActor
    func testAppLaunches() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.images["AppLogo"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Sign In with email"].exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
