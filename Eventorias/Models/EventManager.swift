//
//  EventManager.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 31/08/2025.
//

import Foundation
import FirebaseFirestore

protocol EventFetching {
    func fetchEvents() async throws -> [Event]
}

struct FirestoreEventFetcher: EventFetching {
    func fetchEvents() async throws -> [Event] {
        let snapshot = try await Firestore.firestore().collection("Events").getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: Event.self) }
    }
}

class EventManager: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private let fetcher: EventFetching
    
    init(fetcher: EventFetching = FirestoreEventFetcher()) {
        self.fetcher = fetcher
    }
    
    @MainActor
    func fetchEvents() async {
        isLoading = true
        error = nil
        do {
            events = try await fetcher.fetchEvents()
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
