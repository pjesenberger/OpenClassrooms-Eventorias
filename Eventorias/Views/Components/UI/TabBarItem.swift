//
//  TabBarItem.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 30/08/2025.
//

import SwiftUI

struct TabBarItem: View {
    var text: String
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 8) {
                Image(selectedTab == text ? "\(image)Active" : image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                
                Text(text)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(selectedTab == text ? .appRed : .white)
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedTab = "Profile"
    TabBarItem(text: "Profile", image: "ProfileIcon", selectedTab: $selectedTab)
        .appBackground
}
