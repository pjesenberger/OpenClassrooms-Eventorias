//
//  AuthManager.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 29/08/2025.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var isSignedIn: Bool = Auth.auth().currentUser != nil

    func signOut() {
        try? Auth.auth().signOut()
        isSignedIn = false
    }
}
