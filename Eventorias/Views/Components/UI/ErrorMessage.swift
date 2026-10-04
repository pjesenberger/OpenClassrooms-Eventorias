//
//  ErrorMessage.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 31/08/2025.
//

import SwiftUI

struct ErrorMessage: View {
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .foregroundColor(.appDarkGray)
                .frame(width: 64, height: 64)
                .overlay(
                    Image("ExclamationIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 5, height: 24)
                )
                .padding(.bottom)
            
            Text("Error")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            Text("An error has occured, please try again later")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
                .frame(width: 164)
                .multilineTextAlignment(.center)
            
            CustomButton(
                action: onRetry,
                title: "Try again",
                width: 159,
                height: 40
            )
            .padding(.top, 24)
        }
    }
}

#Preview {
    ErrorMessage(onRetry: {})
        .appBackground
}
