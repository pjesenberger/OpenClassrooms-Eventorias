//
//  EventDetailView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 01/09/2025.
//

import SwiftUI

struct EventDetailView: View {
    var event: Event
    
    var formattedDate: String { DateHelper.formatDate(event.date) }
    var formattedTime: String { DateHelper.formatTime(event.time) }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                EventImage(imageURL: event.image)
                    .padding(.top, 24)
                
                HStack {
                    VStack(alignment: .leading) {
                        EventInfoRow(iconName: "CalendarIcon", text: formattedDate)
                        EventInfoRow(iconName: "ClockIcon", text: formattedTime)
                    }
                    
                    Spacer()
                    
                    EventProfileImage(urlString: event.profileImageURL)
                }
                
                Text(event.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                
                HStack {
                    Text(event.address)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    MapIndicator(geoPoint: event.location)
                }
            }
        }
        .padding(.horizontal)
        .appBackground
        .customBackToolbar(text: event.title)
    }
}

#Preview {
    EventDetailView(event: .preview)
}
