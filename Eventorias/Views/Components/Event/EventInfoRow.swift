//
//  EventInfoRow.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 01/09/2025.
//

import SwiftUI

struct EventInfoRow: View {
    var iconName: String
    var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    EventInfoRow(iconName: "ClockIcon", text: "10:00 AM")
}
