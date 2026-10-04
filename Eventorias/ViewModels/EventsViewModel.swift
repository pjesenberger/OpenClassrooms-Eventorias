//
//  EventsViewModel.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 31/08/2025.
//

import Foundation
import Combine

enum SortOption: String, CaseIterable {
    case dateAsc = "Date ↑"
    case dateDesc = "Date ↓"
    case titleAsc = "A-Z"
    case titleDesc = "Z-A"
}

@MainActor
class EventsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedSortOption: SortOption = .dateAsc
    @Published var filteredEvents: [Event] = []
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    
    var eventManager: EventManager {
        didSet {
            setupBindings()
        }
    }
    var allEvents: [Event] = []
    var cancellables = Set<AnyCancellable>()
    
    init(eventManager: EventManager = EventManager()) {
        self.eventManager = eventManager
        setupBindings()
    }
    
    private func setupBindings() {
        cancellables.removeAll()
        
        eventManager.$events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] events in
                self?.allEvents = events
                self?.filterAndSort()
            }
            .store(in: &cancellables)
        
        eventManager.$isLoading
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        eventManager.$error
            .receive(on: DispatchQueue.main)
            .map { $0 != nil }
            .assign(to: \.hasError, on: self)
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchEvents() async {
        await eventManager.fetchEvents()
    }
    
    func retryFetchEvents() async {
        await fetchEvents()
    }
    
    func refreshEvents() async {
        if hasError {
            hasError = false
        }
        
        await fetchEvents()
        
        try? await Task.sleep(nanoseconds: 800_000_000)
    }
    
    func filterAndSort() {
        var result = allEvents
        
        if !searchText.isEmpty {
            result = result.filter { event in
                event.title.localizedCaseInsensitiveContains(searchText) ||
                event.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        switch selectedSortOption {
        case .dateAsc:
            result = result.sorted { $0.date < $1.date }
        case .dateDesc:
            result = result.sorted { $0.date > $1.date }
        case .titleAsc:
            result = result.sorted { $0.title < $1.title }
        case .titleDesc:
            result = result.sorted { $0.title > $1.title }
        }
        
        filteredEvents = result
    }
}
