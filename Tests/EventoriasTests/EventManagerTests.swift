//
//  EventManagerTests.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 18/09/2025.
//

import XCTest
@testable import Eventorias

struct MockEventFetcher: EventFetching {
    func fetchEvents() async throws -> [Event] {
        return [
            Event(
                id: "1",
                title: "Mock Event",
                description: "Description de test",
                date: "2025-09-18",
                time: "18:00",
                address: "123 Rue de Test",
                image: nil,
                profileImageURL: nil,
                location: nil
            )
        ]
    }
}

@MainActor
final class EventManagerTests: XCTestCase {
    var eventManager: EventManager!
    
    override func setUp() {
        super.setUp()
        eventManager = EventManager(fetcher: MockEventFetcher())
    }
    
    override func tearDown() {
        eventManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(eventManager.events.count, 0)
        XCTAssertFalse(eventManager.isLoading)
        XCTAssertNil(eventManager.error)
    }
    
    func testFetchEventsUpdatesProperties() async {
        XCTAssertFalse(eventManager.isLoading)
        XCTAssertNil(eventManager.error)
        
        await eventManager.fetchEvents()
        
        XCTAssertFalse(eventManager.isLoading)
        XCTAssertNil(eventManager.error)
        XCTAssertEqual(eventManager.events.count, 1)
        XCTAssertEqual(eventManager.events.first?.title, "Mock Event")
    }
    
    func testFetchEventsResetsError() async {
        eventManager.error = NSError(domain: "TestError", code: 1)
        
        await eventManager.fetchEvents()
        
        XCTAssertNil(eventManager.error)
    }
}
