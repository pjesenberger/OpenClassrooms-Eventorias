//
//  LoadingIndicator.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 31/08/2025.
//

import SwiftUI

struct LoadingIndicator: View {
    @State var rotation: Double = 0
    
    var body: some View {
        Image("LoadingIcon")
            .resizable()
            .scaledToFit()
            .frame(width: 48, height: 48)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

#Preview {
    LoadingIndicator()
        .appBackground
}
