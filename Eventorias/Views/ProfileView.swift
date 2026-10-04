//
//  ProfileView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 30/08/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @FocusState var nameFieldFocused: Bool
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Spacer()
                LoadingIndicator()
                Spacer()
            } else {
                VStack(spacing: 24) {
                    CustomTextField(
                        title: "Name",
                        placeholder: viewModel.name.isEmpty ? "No Name" : "",
                        text: $viewModel.name
                    )
                    .focused($nameFieldFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        viewModel.updateUsername()
                        nameFieldFocused = false
                    }
                    
                    CustomTextField(
                        title: "E-mail",
                        placeholder: viewModel.email.isEmpty ? "No E-mail" : "",
                        text: $viewModel.email
                    )
                    .disabled(true)
                    
                    HStack(spacing: 16) {
                        Toggle("", isOn: $viewModel.notificationsEnabled)
                            .labelsHidden()
                            .tint(Color.appRed)
                        
                        Text("Notifications")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .padding()
                .appBackground
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("User profile")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if let photoURL = Auth.auth().currentUser?.photoURL {
                    AsyncImage(url: photoURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color.appRed)
                    }
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundColor(Color.appRed)
                }
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    ProfileView()
}
