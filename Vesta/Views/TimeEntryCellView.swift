//
//  TimeEntryCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimeEntryCellView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var task: Task
    @ObservedObject var timeEntry: TimeEntry
    
    @State private var showingEditTimeEntrySheet = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .padding(.vertical, 4.0)
                HStack {
                    Group {
                        Text(formattedDate(timeEntry: timeEntry))
                        Text(" | ")
                        Text(formattedTimeInterval(timeEntry: timeEntry))
                        Text(" | ")
                    }
                    .foregroundColor(.secondary)
                    Text(formattedDuration(timeEntry: timeEntry))
                }
                .font(.subheadline)
                .padding(.bottom, 2.0)
            }
            Spacer()
            Button(action: {
                showingEditTimeEntrySheet = true
            }, label: {
                Image(systemName: "pencil")
                    .foregroundColor(.accentColor)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showingEditTimeEntrySheet) {
            NavigationView {
                ModifyTimeEntryView(timeEntry: timeEntry)
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
    
    private func formattedDate(timeEntry: TimeEntry) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        
        return dateFormatter.string(from: timeEntry.startDate)
    }
    
    private func formattedTimeInterval(timeEntry: TimeEntry) -> String {
        var startTimeString = "-"
        var endTimeString = "-"
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        startTimeString = dateFormatter.string(from: timeEntry.startDate)
        if let endDate = timeEntry.endDate {
            endTimeString = dateFormatter.string(from: endDate)
        }
        
        return "\(startTimeString) - \(endTimeString)"
    }
    
    private func formattedDuration(timeEntry: TimeEntry) -> String {
        var durationString = "-"
        
        if let endDate = timeEntry.endDate {
            let dateInterval = DateInterval(start: timeEntry.startDate, end: endDate)
            durationString = DataFormatter.formattedDuration(duration: dateInterval.duration)
        }
        
        return durationString
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var task: Task {
        let task = Task(context: PersistenceController.preview.container.viewContext)
        task.title = "Task title"
        task.userOrder = Int16(1)
        
        return task
    }
    
    static var timeEntry: TimeEntry {
        let timeEntry = TimeEntry(context: PersistenceController.preview.container.viewContext)
        timeEntry.startDate = Date(timeIntervalSinceNow: -1234)
        timeEntry.endDate = Date()
        timeEntry.task = task
        
        return timeEntry
    }
    
    static var previews: some View {
        TimeEntryCellView(task: task, timeEntry: timeEntry)
            .previewLayout(.sizeThatFits)
    }
}
