//
//  EventsViewModelTests.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
@testable import Eventorias

@MainActor
final class EventsViewModelTests: XCTestCase {
    var viewModel: EventsViewModel!
    var mockEventManager: MockEventManager!
    
    override func setUp() {
        super.setUp()
        mockEventManager = MockEventManager()
        viewModel = EventsViewModel(eventManager: mockEventManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockEventManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.selectedSortOption, .dateAsc)
        XCTAssertEqual(viewModel.filteredEvents.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.hasError)
    }
    
    func testFilterAndSort() {
        let events = [
            Event(id: "1", title: "Jazz Concert", description: "Evening jazz", date: "2024-01-15", time: "20:00", address: "Hall", image: nil, profileImageURL: nil, location: nil),
            Event(id: "2", title: "Tech Conference", description: "Tech trends", date: "2024-02-20", time: "09:00", address: "Center", image: nil, profileImageURL: nil, location: nil),
            Event(id: "3", title: "Summer Festival", description: "Music festival", date: "2024-03-10", time: "14:00", address: "Park", image: nil, profileImageURL: nil, location: nil)
        ]
        viewModel.allEvents = events
        
        viewModel.searchText = "tech"
        viewModel.selectedSortOption = .titleAsc
        viewModel.filterAndSort()
        
        XCTAssertEqual(viewModel.filteredEvents.count, 1)
        XCTAssertEqual(viewModel.filteredEvents.first?.title, "Tech Conference")
        
        viewModel.searchText = ""
        viewModel.selectedSortOption = .dateDesc
        viewModel.filterAndSort()
        
        XCTAssertEqual(viewModel.filteredEvents.map(\.date), ["2024-03-10", "2024-02-20", "2024-01-15"])
    }
    
    func testFetchEventsSetsProperties() async {
        mockEventManager.shouldSucceed = true
        await viewModel.fetchEvents()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertTrue(mockEventManager.fetchEventsCalled)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.hasError)
        XCTAssertEqual(viewModel.allEvents.count, 1)
    }
    
    func testErrorHandling() async {
        mockEventManager.shouldSucceed = false
        await viewModel.fetchEvents()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertTrue(viewModel.hasError)
        XCTAssertFalse(viewModel.isLoading)
    }
}
