//
//  MockEventManager.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
@testable import Eventorias

class MockEventManager: EventManager {
    var fetchEventsCalled = false
    var shouldSucceed = true
    
    override func fetchEvents() async {
        fetchEventsCalled = true
        
        if shouldSucceed {
            let testEvents = [
                Event(id: "1", title: "Test Event", description: "Test Description",
                      date: "2024-01-15", time: "19:00", address: "Test Location",
                      image: nil, profileImageURL: nil, location: nil)
            ]
            
            await MainActor.run {
                self.events = testEvents
                self.isLoading = false
                self.error = nil
            }
        } else {
            await MainActor.run {
                self.error = NSError(domain: "TestError", code: 1, userInfo: nil)
                self.isLoading = false
            }
        }
    }
}
