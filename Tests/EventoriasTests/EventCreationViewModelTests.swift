//
//  EventCreationViewModelTests.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
import UIKit
@testable import Eventorias

@MainActor
final class EventCreationViewModelTests: XCTestCase {
    var viewModel: EventCreationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = EventCreationViewModel()
    }
    
    func testDateValidation() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        viewModel.eventDate = formatter.string(from: Date().addingTimeInterval(-86400))
        XCTAssertFalse(viewModel.isDateValid())
        
        viewModel.eventDate = formatter.string(from: Date().addingTimeInterval(86400))
        XCTAssertTrue(viewModel.isDateValid())
    }
    
    func testTimeValidation() {
        let invalidTimes = ["25:00", "99 : 99", "abc"]
        let validTimes = ["14 : 30", "09 : 05"]
        
        for time in invalidTimes {
            viewModel.eventTime = time
            XCTAssertFalse(viewModel.isTimeValid())
        }
        
        for time in validTimes {
            viewModel.eventTime = time
            XCTAssertTrue(viewModel.isTimeValid())
        }
    }
    
    func testCanSubmit() {
        viewModel.eventName = "Test"
        viewModel.eventDescription = "Desc"
        viewModel.eventAddress = "Address"
        viewModel.eventImage = UIImage()
        viewModel.eventDate = "12/31/2025"
        viewModel.eventTime = "14 : 30"
        
        XCTAssertTrue(viewModel.canSubmit)
        
        viewModel.eventName = ""
        XCTAssertFalse(viewModel.canSubmit)
    }
    
    func testValidateAddress() {
        let expectationValid = expectation(description: "Valid address")
        viewModel.eventAddress = "1 Apple Park Way, Cupertino, CA"
        
        viewModel.validateAddressOnSubmit { isValid in
            XCTAssertTrue(isValid)
            XCTAssertTrue(self.viewModel.isAddressValid)
            XCTAssertNil(self.viewModel.errorMessage)
            expectationValid.fulfill()
        }
        
        let expectationInvalid = expectation(description: "Invalid address")
        viewModel.eventAddress = "invalid xyz"
        
        viewModel.validateAddressOnSubmit { isValid in
            XCTAssertFalse(isValid)
            XCTAssertFalse(self.viewModel.isAddressValid)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectationInvalid.fulfill()
        }
        
        wait(for: [expectationValid, expectationInvalid], timeout: 5)
    }
    
    func testValidateFieldsErrorMessages() {
        viewModel.validateFields()
        XCTAssertEqual(viewModel.errorMessage, "Please fill in all fields")
        
        viewModel.eventName = "Test"
        viewModel.eventDescription = "Test"
        viewModel.eventAddress = "Test"
        viewModel.validateFields()
        XCTAssertEqual(viewModel.errorMessage, "Please select an image for the event")
        
        viewModel.eventImage = UIImage()
        viewModel.eventDate = "invalid"
        viewModel.validateFields()
        XCTAssertEqual(viewModel.errorMessage, "Incorrect date format or date is in the past. Use MM/DD/YYYY")
        
        viewModel.eventDate = "12/31/2025"
        viewModel.eventTime = "25:00"
        viewModel.validateFields()
        XCTAssertEqual(viewModel.errorMessage, "Incorrect time format. Use HH : MM")
        
        viewModel.eventTime = "14 : 30"
        viewModel.validateFields()
        XCTAssertNil(viewModel.errorMessage)
    }
}
