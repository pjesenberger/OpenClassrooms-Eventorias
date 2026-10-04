//
//  EventImage.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 01/09/2025.
//

import SwiftUI

struct EventImage: View {
    var imageURL: String?
    
    var body: some View {
        GeometryReader { geometry in
            if let urlString = imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 364)
                        .clipped()
                        .cornerRadius(12)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: geometry.size.width, height: 364)
                        .cornerRadius(12)
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: 364)
                    .cornerRadius(12)
            }
        }
        .frame(height: 364)
    }
}

#Preview {
    EventImage(imageURL: "https://media.discordapp.net/attachments/729528999335952444/1411540205575475341/883519-brunch-paint-l-insolite-brunch-creatif-de-la-galerie-wawi-b3ff022d-3509-48d6-bbf0-1c0a14c95ce1.jpg?ex=68b5af82&is=68b45e02&hm=1bccc110de11bcdb478d35c861015d7d3f0e0bd3f3a62e0a05ae6227bc208754&=&format=webp&width=2622&height=1966")
}
