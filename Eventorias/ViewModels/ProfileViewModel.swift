//
//  ProfileViewModel.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 10/09/2025.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var notificationsEnabled: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    init() {
        loadUser()
    }
    
    func loadUser() {
        let user = Auth.auth().currentUser
        name = user?.displayName ?? ""
        email = user?.email ?? ""
    }
    
    func updateUsername() {
        guard let user = Auth.auth().currentUser else { return }
        
        isLoading = true
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        
        changeRequest.commitChanges { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.alertMessage = "Failed to update profile: \(error.localizedDescription)"
                    self?.showAlert = true
                } else {
                    self?.alertMessage = "Profile updated successfully!"
                    self?.showAlert = true
                }
            }
        }
    }
}
