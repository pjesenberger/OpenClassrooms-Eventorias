//
//  EventCreationViewModel.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 05/09/2025.
//

import Foundation
import UIKit
import CoreLocation
import FirebaseFirestore

class EventCreationViewModel: ObservableObject {
    @Published var eventName = "" { didSet { validateFields() } }
    @Published var eventDescription = "" { didSet { validateFields() } }
    @Published var eventDate = "" { didSet { validateFields() } }
    @Published var eventTime = "" { didSet { validateFields() } }
    @Published var eventAddress = "" { didSet { validateFields() } }
    @Published var eventImage: UIImage? { didSet { validateFields() } }
    @Published var showCamera = false
    @Published var showGallery = false
    @Published var errorMessage: String?
    @Published var eventLocation: CLLocationCoordinate2D?
    @Published var isAddressValid = false
    @Published var imageURL: String?
    @Published var isCreatingEvent = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var shouldDismiss = false
    
    let imageUploadService = ImageUploadService()
    let db = Firestore.firestore()
    
    var canSubmit: Bool {
        !eventName.isEmpty &&
        !eventDescription.isEmpty &&
        !eventAddress.isEmpty &&
        eventImage != nil &&
        isDateValid() &&
        isTimeValid() &&
        !isCreatingEvent
    }
    
    func validateFields() {
        if eventName.isEmpty || eventDescription.isEmpty || eventAddress.isEmpty {
            errorMessage = "Please fill in all fields"
        } else if eventImage == nil {
            errorMessage = "Please select an image for the event"
        } else if !isDateValid() {
            errorMessage = "Incorrect date format or date is in the past. Use MM/DD/YYYY"
        } else if !isTimeValid() {
            errorMessage = "Incorrect time format. Use HH : MM"
        } else {
            errorMessage = nil
        }
    }
    
    func isDateValid() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let date = formatter.date(from: eventDate) else { return false }
        return Calendar.current.startOfDay(for: date) >= Calendar.current.startOfDay(for: Date())
    }
    
    func isTimeValid() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH : mm"
        return formatter.date(from: eventTime) != nil
    }
    
    func validateAddressOnSubmit(completion: @escaping (Bool) -> Void) {
        let trimmedAddress = eventAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = trimmedAddress.components(separatedBy: " ")
        
        guard components.count >= 3,
              components.contains(where: { $0.rangeOfCharacter(from: .decimalDigits) != nil }) else {
            self.isAddressValid = false
            self.errorMessage = "Please enter a complete address (number, street, city)"
            completion(false)
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(trimmedAddress) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                guard error == nil,
                      let placemark = placemarks?.first,
                      let coordinate = placemark.location?.coordinate,
                      placemark.subThoroughfare != nil,
                      placemark.thoroughfare != nil,
                      (placemark.locality != nil || placemark.subLocality != nil) else {
                    self?.isAddressValid = false
                    self?.errorMessage = "Address not found or incomplete"
                    completion(false)
                    return
                }
                
                self?.eventLocation = coordinate
                self?.isAddressValid = true
                self?.errorMessage = nil
                completion(true)
            }
        }
    }
    
    func createEvent() {
        guard let image = eventImage else { return }
        
        isCreatingEvent = true
        errorMessage = nil
        
        imageUploadService.uploadImage(image) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let url):
                    self?.imageURL = url
                    self?.saveEventToFirestore()
                case .failure(let error):
                    self?.isCreatingEvent = false
                    self?.alertMessage = "Failed to upload image: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
    
    func saveEventToFirestore() {
        let event = Event(
            title: eventName,
            description: eventDescription,
            date: eventDate,
            time: eventTime,
            address: eventAddress,
            image: imageURL,
            location: eventGeoPoint
        )
        
        do {
            _ = try db.collection("Events").addDocument(from: event)
            isCreatingEvent = false
            shouldDismiss = true
        } catch {
            isCreatingEvent = false
            alertMessage = "Failed to create event: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    var eventGeoPoint: GeoPoint? {
        guard let location = eventLocation else { return nil }
        return GeoPoint(latitude: location.latitude, longitude: location.longitude)
    }
}
