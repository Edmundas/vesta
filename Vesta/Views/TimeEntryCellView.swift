//
//  TimeEntryCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimeEntryCellView: View {
    @ObservedObject var task: Task
    @ObservedObject var timeEntry: TimeEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title ?? "")
                .font(.headline)
                .padding(.bottom, 2.0)
            if let startDate = timeEntry.startDate {
                Text("\(DataFormatter.formattedDate(date: startDate)) \(DataFormatter.formattedTime(date: startDate))")
                    .font(.subheadline)
            }
            if let endDate = timeEntry.endDate {
                Text("\(DataFormatter.formattedDate(date: endDate)) \(DataFormatter.formattedTime(date: endDate))")
                    .font(.subheadline)
            } else {
                Text("-")
                    .font(.subheadline)
            }
            if let startDate = timeEntry.startDate,
               let endDate = timeEntry.endDate {
                let dateInterval = DateInterval(start: startDate, end: endDate)
                Text(DataFormatter.formattedDuration(duration: dateInterval.duration))
                    .font(.subheadline)
                    .padding(.top, 2.0)
            } else {
                Text("-")
                    .font(.subheadline)
                    .padding(.top, 2.0)
            }
        }
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var task: Task {
        let task = Task(context: PersistenceController.preview.container.viewContext)
        task.id = UUID()
        task.title = "Task title"
        task.userOrder = Int64(1)
        
        return task
    }
    
    static var timeEntry: TimeEntry {
        let timeEntry = TimeEntry(context: PersistenceController.preview.container.viewContext)
        timeEntry.id = UUID()
        timeEntry.startDate = Date(timeIntervalSinceNow: -3600)
        timeEntry.endDate = Date()
        timeEntry.task = task
        
        return timeEntry
    }
    
    static var previews: some View {
        TimeEntryCellView(task: task, timeEntry: timeEntry)
            .previewLayout(.sizeThatFits)
    }
}
