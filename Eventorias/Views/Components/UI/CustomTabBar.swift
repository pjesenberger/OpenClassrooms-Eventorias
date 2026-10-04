//
//  CustomTabBar.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 30/08/2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack(spacing: 46) {
            Spacer()
            
            TabBarItem(text: "Events", image: "EventIcon", selectedTab: $selectedTab)
                .onTapGesture { selectedTab = "Events" }
                .accessibilityElement()
                .accessibilityLabel("Événements")
                .accessibilityAddTraits(selectedTab == "Events" ? .isSelected : .isButton)
            
            TabBarItem(text: "Profile", image: "ProfileIcon", selectedTab: $selectedTab)
                .onTapGesture { selectedTab = "Profile" }
                .accessibilityElement()
                .accessibilityLabel("Profil")
                .accessibilityAddTraits(selectedTab == "Profile" ? .isSelected : .isButton)
            
            Spacer()
        }
        .frame(height: 56)
    }
}

#Preview {
    @Previewable @State var selectedTab = "Events"
    CustomTabBar(selectedTab: $selectedTab)
}
