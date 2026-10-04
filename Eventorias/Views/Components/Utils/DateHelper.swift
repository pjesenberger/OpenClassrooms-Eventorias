//
//  DateHelper.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 31/08/2025.
//

import Foundation

struct DateHelper {
    static func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else { return dateString }
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    static func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let date = formatter.date(from: timeString) else { return timeString }
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}
