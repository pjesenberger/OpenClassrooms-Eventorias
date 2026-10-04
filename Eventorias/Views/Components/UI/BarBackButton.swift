//
//  BarBackButton.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 28/08/2025.
//

import SwiftUI

struct BarBackButton: View {
    var text: String? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            Image("ArrowBackIcon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 24, maxHeight: 24)
            
            if let text {
                Text(text)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    BarBackButton(text: "Back")
        .appBackground
}
