//
//  EventRow.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 31/08/2025.
//

import SwiftUI

struct EventRow: View {
    var event: Event
    
    var formattedDate: String {
        DateHelper.formatDate(event.date)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.appDarkGray)
            
            HStack(spacing: 12) {
                HStack(spacing: 12) {
                    EventProfileImage(urlString: event.profileImageURL, imageSize: 40)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Text(formattedDate)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
                .padding(.leading, 12)
                
                Spacer(minLength: 0)
                
                if let urlString = event.image, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 136, height: 80)
                            .clipped()
                            .cornerRadius(12)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 136, height: 80)
                            .cornerRadius(12)
                    }
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 136, height: 80)
                        .cornerRadius(12)
                }
            }
        }
        .frame(height: 80)
    }
}

#Preview {
    EventRow(
        event: .preview
    )
    .frame(maxWidth: .infinity)
    .padding()
}
