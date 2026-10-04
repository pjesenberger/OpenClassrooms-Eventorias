//
//  AuthenticationView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 28/08/2025.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var viewModel: AuthenticationViewModel
    @FocusState var focusedField: Field?

    enum Field {
        case email, password
    }

    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: AuthenticationViewModel(authManager: authManager))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Sign In / Sign Up")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 64)

                VStack(spacing: 24) {
                    CustomTextField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $viewModel.email
                    )
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }

                    CustomTextField(
                        title: "Password",
                        placeholder: "Enter your password",
                        text: $viewModel.password
                    )
                    .focused($focusedField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit { viewModel.submit() }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.appRed)
                            .multilineTextAlignment(.center)
                    }
                    
                    CustomButton(
                        action: { viewModel.submit() },
                        title: viewModel.isLoading ? "Processing..." : "Sign In",
                        width: 242
                    )
                    .disabled(!viewModel.canSubmit)
                    .opacity(viewModel.canSubmit ? 1.0 : 0.5)
                }

                Spacer()
            }
        }
        .padding(.horizontal)
        .appBackground
        .alert("Create Account", isPresented: $viewModel.showSignupConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Create Account") {
                viewModel.signUp()
            }
        } message: {
            Text("No account found with this email. Would you like to create a new account?")
        }
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    AuthenticationView(authManager: AuthManager())
}
