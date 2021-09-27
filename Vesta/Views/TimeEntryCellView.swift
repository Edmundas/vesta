//
//  TimeEntryCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimeEntryCellView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var task: CDTask
    @ObservedObject var timeEntry: CDTimeEntry
    
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
            .disabled(timeEntry.endDate == nil)
        }
        .sheet(isPresented: $showingEditTimeEntrySheet) {
            NavigationView {
                ModifyTimeEntryView(timeEntry: timeEntry)
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
        .deleteDisabled(timeEntry.endDate == nil)
    }
    
    private func formattedDate(timeEntry: CDTimeEntry) -> String {
        guard !timeEntry.isFault else { return "-" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        
        return dateFormatter.string(from: timeEntry.startDate)
    }
    
    private func formattedTimeInterval(timeEntry: CDTimeEntry) -> String {
        guard !timeEntry.isFault else { return "-" }
        
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
    
    private func formattedDuration(timeEntry: CDTimeEntry) -> String {
        guard !timeEntry.isFault else { return "-" }
        
        var durationString = "-"
        
        if let endDate = timeEntry.endDate {
            let dateInterval = DateInterval(start: timeEntry.startDate, end: endDate)
            durationString = DataFormatter.formattedDuration(duration: dateInterval.duration)
        }
        
        return durationString
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var task: CDTask {
        let task = CDTask(context: PersistenceController.preview.container.viewContext)
        task.title = "Task title"
        task.userOrder = Int16(1)
        
        return task
    }
    
    static var timeEntry: CDTimeEntry {
        let timeEntry = CDTimeEntry(context: PersistenceController.preview.container.viewContext)
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
