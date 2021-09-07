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
                Text(DataFormatter.formattedDate(date: dateInterval.start))
                Text(DataFormatter.formattedTime(date: dateInterval.start))
                Text(DataFormatter.formattedTime(date: dateInterval.end))
                Text(DataFormatter.formattedDuration(duration: dateInterval.duration))
            }
            .font(.headline)
        }
        .padding(.vertical)
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var previews: some View {
        DateIntervalCellView(dateInterval: DateInterval(start: Date(), duration: 100))
            .previewLayout(.sizeThatFits)
    }
}
