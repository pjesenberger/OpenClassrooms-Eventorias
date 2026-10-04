//
//  EventProfileImage.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 01/09/2025.
//

import SwiftUI

struct EventProfileImage: View {
    var urlString: String?
    var imageSize: CGFloat = 60
    
    var body: some View {
        if let urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                Circle().fill(Color.gray)
            }
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.appRed)
        }
    }
}

#Preview {
    EventProfileImage()
}
