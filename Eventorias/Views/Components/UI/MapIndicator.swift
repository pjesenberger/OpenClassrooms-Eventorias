//
//  MapIndicator.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 01/09/2025.
//

import SwiftUI
import MapKit
import FirebaseFirestore

struct MapIndicator: View {
    let coordinate: CLLocationCoordinate2D?
    
    init(latitude: Double?, longitude: Double?) {
        if let lat = latitude, let lon = longitude, lat >= -90, lat <= 90, lon >= -180, lon <= 180 {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        } else {
            self.coordinate = nil
        }
    }
    
    init(geoPoint: GeoPoint?) {
        if let gp = geoPoint, gp.latitude >= -90, gp.latitude <= 90, gp.longitude >= -180, gp.longitude <= 180 {
            self.coordinate = CLLocationCoordinate2D(latitude: gp.latitude, longitude: gp.longitude)
        } else {
            self.coordinate = nil
        }
    }
    
    var body: some View {
        if let coord = coordinate {
            Map(initialPosition: .region(MKCoordinateRegion(
                center: coord,
                span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
            )), interactionModes: []) {
                Marker("Position", coordinate: coord)
                    .tint(.red)
            }
            .frame(width: 149, height: 72)
            .cornerRadius(12)
            .allowsHitTesting(false)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray)
                Text("Invalid coordinates")
                    .font(.system(size: 12).weight(.medium))
                    .foregroundColor(.white)
            }
            .frame(width: 149, height: 72)
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        MapIndicator(latitude: 48.8566, longitude: 2.3522)
        MapIndicator(latitude: nil, longitude: nil)
        MapIndicator(geoPoint: nil)
    }
    .padding()
}
