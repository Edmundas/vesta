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
        HStack {
            VStack(alignment: .leading) {
                Label("Date", systemImage: "calendar")
                Label("Start", systemImage: "hourglass.bottomhalf.fill")
                Label("End", systemImage: "hourglass.tophalf.fill")
                Label("Duration", systemImage: "clock")
            }
            .font(.subheadline)
            Spacer()
            VStack(alignment: .trailing) {
                Text(formattedDate(date: dateInterval.start))
                Text(formattedTime(date: dateInterval.start))
                Text(formattedTime(date: dateInterval.end))
                Text(formattedDuration(duration: dateInterval.duration))
            }
            .font(.headline)
        }
        .padding(.vertical)
    }
    
    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    private func formattedTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    private func formattedDuration(duration: Double) -> String {
        let s = Int(duration) % 60
        let m = Int(duration) / 60
        let h = Int(duration) / 360
        
        return String(format:"%02d:%02d:%02d", h, m, s)
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var previews: some View {
        DateIntervalCellView(dateInterval: DateInterval(start: Date(), duration: 100))
            .previewLayout(.sizeThatFits)
    }
}
