//
//  EventsView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 30/08/2025.
//

import SwiftUI

struct EventsView: View {
    @StateObject var viewModel = EventsViewModel()
    
    var body: some View {
        VStack(spacing: 14) {
            CustomSearchBar(
                searchText: $viewModel.searchText,
                action: { viewModel.filterAndSort() },
                onCancel: {
                    viewModel.searchText = ""
                    viewModel.filterAndSort()
                }
            )
            .padding(.top, 24)
            
            SortingButton(selectedSortOption: $viewModel.selectedSortOption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onChange(of: viewModel.selectedSortOption) {
                    viewModel.filterAndSort()
                }
            
            if viewModel.hasError {
                Spacer()
                
                ErrorMessage(onRetry: {
                    Task {
                        await viewModel.retryFetchEvents()
                    }
                })
                
                Spacer()
            } else if viewModel.isLoading {
                Spacer()
                
                LoadingIndicator()
                
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.filteredEvents) { event in
                            NavigationLink(destination: EventDetailView(event: event)
                            ) {
                                EventRow(event: event)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .refreshable {
                    await viewModel.refreshEvents()
                }
            }
        }
        .task {
            await viewModel.fetchEvents()
        }
        .appBackground
    }
}

#Preview {
    EventsView()
}
