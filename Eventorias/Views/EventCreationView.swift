//
//  EventCreationView.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 01/09/2025.
//

import SwiftUI

struct EventCreationView: View {
    @StateObject var viewModel = EventCreationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 22) {
                    CustomTextField(
                        title: "Title",
                        placeholder: "New event",
                        text: $viewModel.eventName
                    )
                    
                    CustomTextField(
                        title: "Description",
                        placeholder: "Tap here to enter your description",
                        text: $viewModel.eventDescription
                    )
                    
                    HStack(spacing: 16) {
                        CustomTextField(
                            title: "Date",
                            placeholder: "MM/DD/YYYY",
                            text: $viewModel.eventDate
                        )
                        
                        CustomTextField(
                            title: "Time",
                            placeholder: "HH : MM",
                            text: $viewModel.eventTime
                        )
                    }
                    
                    CustomTextField(
                        title: "Address",
                        placeholder: "Enter full address",
                        text: $viewModel.eventAddress
                    )
                    
                    HStack(spacing: 16) {
                        Spacer()
                        CustomButton(
                            action: { viewModel.showCamera = true },
                            image: Image("CameraIcon"),
                            cornerRadius: 16,
                            backgroundColor: .white,
                            width: 52,
                            height: 52,
                            imageSize: 20
                        )
                        CustomButton(
                            action: { viewModel.showGallery = true },
                            image: Image("AttachIcon"),
                            cornerRadius: 16,
                            width: 52,
                            height: 52,
                            imageSize: 20
                        )
                        Spacer()
                    }
                    .padding(.top)
                    
                    Spacer()
                }
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.appRed)
                    .multilineTextAlignment(.center)
            }
            
            CustomButton(
                action: {
                    viewModel.validateAddressOnSubmit { success in
                        if success {
                            viewModel.createEvent()
                        }
                    }
                },
                title: viewModel.isCreatingEvent ? "Creating..." : "Validate"
            )
            .disabled(!viewModel.canSubmit)
            .opacity(viewModel.canSubmit ? 1.0 : 0.5)
            .padding(.vertical)
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $viewModel.eventImage)
        }
        .fullScreenCover(isPresented: $viewModel.showGallery) {
            PhotoPicker(selectedImage: $viewModel.eventImage, isPresented: $viewModel.showGallery)
        }
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
        .customBackToolbar(text: "Creation of an event")
        .appBackground
    }
}

#Preview {
    EventCreationView()
}
