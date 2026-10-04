//
//  WelcomeView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 28/08/2025.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var authManager: AuthManager
    @State var showSignIn = false

    var body: some View {
        VStack(spacing: 64) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 242, maxHeight: 120)
            
            CustomButton(
                action: { showSignIn = true },
                title: "Sign In with email",
                image: Image("MailIcon"),
                width: 242
            )
            
            Spacer()
        }
        .padding(.top, 142)
        .appBackground
        .fullScreenCover(isPresented: $showSignIn) {
            AuthenticationView(authManager: authManager)
        }
    }
}

#Preview {
    WelcomeView(authManager: AuthManager())
}
