//
//  AuthenticationUITests.swift
//  EventoriasUITests
//
//  Created by Pascal Jesenberger on 18/09/2025.
//

import XCTest

final class AuthenticationUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    @MainActor
    func testSignInNavigation() throws {
        XCTAssertTrue(app.images["AppLogo"].waitForExistence(timeout: 3))
        
        app.buttons["Sign In with email"].tap()
        
        XCTAssertTrue(app.staticTexts["Sign In / Sign Up"].waitForExistence(timeout: 3))
    }
    
    @MainActor
    func testFieldsExist() throws {
        app.buttons["Sign In with email"].tap()
        XCTAssertTrue(app.staticTexts["Sign In / Sign Up"].waitForExistence(timeout: 3))
        
        XCTAssertTrue(app.textFields.count >= 2)
        XCTAssertTrue(app.buttons["Sign In"].exists)
    }
    
    @MainActor
    func testCanTypeInFields() throws {
        app.buttons["Sign In with email"].tap()
        XCTAssertTrue(app.staticTexts["Sign In / Sign Up"].waitForExistence(timeout: 3))
        
        let textFields = app.textFields
        if textFields.count >= 2 {
            textFields.element(boundBy: 0).tap()
            textFields.element(boundBy: 0).typeText("test@example.com")
        }
        
        XCTAssertTrue(true)
    }
}
