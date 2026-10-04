//
//  EventoriasApp.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 26/08/2025.
//

import SwiftUI

@main
struct EventoriasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if authManager.isSignedIn {
                    HomeView()
                        .environmentObject(authManager)
                } else {
                    WelcomeView(authManager: authManager)
                        .environmentObject(authManager)
                }
            }
        }
    }
}
