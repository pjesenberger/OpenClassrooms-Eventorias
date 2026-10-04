//
//  EventCreationUITests.swift
//  EventoriasUITests
//
//  Created by Pascal Jesenberger on 18/09/2025.
//

import XCTest

final class EventCreationUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    @MainActor
    func testEventCreationExists() throws {
        signIn()
        
        let plusButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS '+'"))
        if plusButtons.count > 0 {
            plusButtons.firstMatch.tap()
            XCTAssertTrue(app.staticTexts["Creation of an event"].waitForExistence(timeout: 3))
        }
    }
    
    @MainActor
    func testFormHasFields() throws {
        signIn()
        
        let plusButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS '+'"))
        if plusButtons.count > 0 {
            plusButtons.firstMatch.tap()
            XCTAssertTrue(app.staticTexts["Creation of an event"].waitForExistence(timeout: 3))
            
            XCTAssertTrue(app.textFields.count >= 5)
            XCTAssertTrue(app.buttons["Validate"].exists)
        }
    }
    
    private func signIn() {
        app.buttons["Sign In with email"].tap()
        XCTAssertTrue(app.staticTexts["Sign In / Sign Up"].waitForExistence(timeout: 3))
        
        let textFields = app.textFields
        if textFields.count >= 2 {
            textFields.element(boundBy: 0).tap()
            textFields.element(boundBy: 0).typeText("test@example.com")
            
            textFields.element(boundBy: 1).tap()
            textFields.element(boundBy: 1).typeText("password123")
        }
        
        app.buttons["Sign In"].tap()
    }
}
