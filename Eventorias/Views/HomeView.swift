//
//  HomeView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 26/08/2025.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab: String = "Events"
    @State var showEventCreation = false
    let tabBarHeight: CGFloat = 56
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if selectedTab == "Events" {
                    EventsView()
                } else if selectedTab == "Profile" {
                    ProfileView()
                }
                CustomTabBar(selectedTab: $selectedTab)
            }
            
            if selectedTab == "Events" {
                CustomButton(
                    action: {
                        showEventCreation = true
                    },
                    image: Image("PlusIcon"),
                    cornerRadius: 16,
                    width: 56,
                    height: 56,
                    imageSize: 18
                )
                .padding(.trailing, 8)
                .padding(.bottom, tabBarHeight + 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .navigationDestination(isPresented: $showEventCreation) {
            EventCreationView()
        }
        .ignoresSafeArea(.keyboard)
        .appBackground
    }
}

#Preview {
    HomeView()
}
