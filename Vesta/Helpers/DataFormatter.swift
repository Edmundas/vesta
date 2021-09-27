//
//  DataFormatter.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-06.
//

import SwiftUI

struct DataFormatter {
    static func formattedDuration(duration: Double) -> String {
        let s = Int(duration) % 60
        let m = Int(duration) / 60
        let h = Int(duration) / 3600
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmmss")

        let calendar = Calendar.current
        let dateComponents = DateComponents(calendar: calendar, hour: h, minute: m, second: s)

        guard let date = dateComponents.date else { return "" }
        return dateFormatter.string(from: date)
    }
}
