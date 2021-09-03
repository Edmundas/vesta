//
//  DateIntervalCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct DateIntervalCellView: View {
    let dateInterval: DateInterval
    
    var body: some View {
        VStack {
            HStack {
                Label("Start", systemImage: "hourglass.bottomhalf.fill")
                    .font(.subheadline)
                Spacer()
                Text(formattedDate(date: dateInterval.start))
                    .font(.headline)
            }
            HStack {
                Label("End", systemImage: "hourglass.tophalf.fill")
                    .font(.subheadline)
                Spacer()
                Text(formattedDate(date: dateInterval.end))
                    .font(.headline)
            }
            HStack {
                Label("Duration", systemImage: "clock")
                    .font(.subheadline)
                Spacer()
                Text(formattedDuration(duration: dateInterval.duration))
                    .font(.headline)
            }
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
    
    private func formattedDuration(duration: Double) -> String {
        let s = Int(duration) % 60
        let m = Int(duration) / 60
        let h = Int(duration) / 360
        let d = Int(duration) / 8640
        
        return String(format:"%02d:%02d:%02d:%02d", d, h, m, s)
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var previews: some View {
        DateIntervalCellView(dateInterval: DateInterval(start: Date(), duration: 100))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
