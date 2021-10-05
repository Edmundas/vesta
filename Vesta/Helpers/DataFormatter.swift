//
//  DataFormatter.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-06.
//

import SwiftUI

struct DataFormatter {
    static func formattedDuration(startDate: Date, endDate: Date) -> String {
        guard startDate <= endDate else { return "-" }
        
        let dateInterval = DateInterval(start: startDate, end: endDate)
        let durationString = formattedDuration(duration: dateInterval.duration)
        
        return durationString
    }
    
    static func formattedDuration(duration: Double) -> String {
        let durationToFormat = duration < 0 ? 0 : duration
        
        let s = Int(durationToFormat) % 60
        let m = Int(durationToFormat) / 60
        let h = Int(durationToFormat) / 3600
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmmss")

        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, hour: h, minute: m, second: s)

        guard let date = dateComponents.date else { return "-" }
        return dateFormatter.string(from: date)
    }
    
    static func formattedMonthDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMdd")
        
        return dateFormatter.string(from: date)
    }
    
    static func formattedHourMinute(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmm")
        
        return dateFormatter.string(from: date)
    }
    
    static func formattedTimeInterval(startDate: Date, endDate: Date) -> String {
        let formatter = DateIntervalFormatter()
        formatter.dateTemplate = "HHmm"
        
        return formatter.string(from: startDate, to: endDate)
    }
}
