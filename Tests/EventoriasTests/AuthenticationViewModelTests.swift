//
//  AuthenticationViewModelTests.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
import FirebaseAuth
@testable import Eventorias

class AuthenticationViewModelTests: XCTestCase {
    var viewModel: AuthenticationViewModel!
    var mockAuthManager: MockAuthManager!
    
    override func setUp() {
        mockAuthManager = MockAuthManager()
        viewModel = AuthenticationViewModel(authManager: mockAuthManager)
    }
    
    func testEmailValidation() {
        viewModel.email = "invalid-email"
        XCTAssertFalse(viewModel.isEmailValid)
        
        viewModel.email = "valid@email.com"
        XCTAssertTrue(viewModel.isEmailValid)
    }
    
    func testPasswordValidation() {
        viewModel.password = "weak"
        XCTAssertFalse(viewModel.isPasswordValid)
        
        viewModel.password = "StrongPass123"
        XCTAssertTrue(viewModel.isPasswordValid)
    }
    
    func testCanSubmit() {
        viewModel.email = "test@test.com"
        viewModel.password = "ValidPass123"
        XCTAssertTrue(viewModel.canSubmit)
        
        viewModel.isLoading = true
        XCTAssertFalse(viewModel.canSubmit)
    }
    
    func testHandleAuthError_WrongPassword() {
        let error = NSError(domain: "FIRAuthErrorDomain", code: AuthErrorCode.wrongPassword.rawValue, userInfo: nil)
        
        viewModel.handleAuthError(error)
        
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Incorrect password")
    }
    
    func testHandleAuthError_EmailAlreadyInUse() {
        let error = NSError(domain: "FIRAuthErrorDomain", code: AuthErrorCode.emailAlreadyInUse.rawValue, userInfo: nil)
        
        viewModel.handleAuthError(error)
        
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "An account already exists with this email")
    }
    
    func testHandleAuthError_UserNotFound() {
        let error = NSError(domain: "FIRAuthErrorDomain", code: AuthErrorCode.userNotFound.rawValue, userInfo: nil)
        
        viewModel.handleAuthError(error)
        
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "No account found with this email")
    }
}
