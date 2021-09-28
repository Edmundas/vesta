//
//  DataFormatter.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-06.
//

import SwiftUI

struct DataFormatter {
    static func formattedDuration(startDate: Date?, endDate: Date?) -> String {
        guard startDate != nil && endDate != nil else { return "-" }
        
        let dateInterval = DateInterval(start: startDate!, end: endDate!)
        let durationString = formattedDuration(duration: dateInterval.duration)
        
        return durationString
    }
    
    static func formattedDuration(duration: Double) -> String {
        let s = Int(duration) % 60
        let m = Int(duration) / 60
        let h = Int(duration) / 3600
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmmss")

        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, hour: h, minute: m, second: s)

        guard let date = dateComponents.date else { return "-" }
        return dateFormatter.string(from: date)
    }
}
