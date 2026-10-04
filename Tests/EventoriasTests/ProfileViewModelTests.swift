//
//  ProfileViewModelTests.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
@testable import Eventorias

class ProfileViewModelTests: XCTestCase {
    var viewModel: ProfileViewModel!
    
    override func setUp() {
        viewModel = ProfileViewModel()
    }
    
    func testInitialState() {
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "")
    }
    
    func testLoadingState() {
        viewModel.isLoading = false
        XCTAssertFalse(viewModel.isLoading)
        
        viewModel.isLoading = true
        XCTAssertTrue(viewModel.isLoading)
    }
}
