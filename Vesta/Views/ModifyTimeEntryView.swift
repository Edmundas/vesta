//
//  ModifyTimeEntryView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct ModifyTimeEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var timeEntry: TimeEntry
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    init(timeEntry: TimeEntry) {
        _timeEntry = State(initialValue: timeEntry)
        if let sDate = timeEntry.startDate {
            _startDate = State(initialValue: sDate)
        }
        if let eDate = timeEntry.endDate {
            _endDate = State(initialValue: eDate)
        }
    }
    
    var body: some View {
        List {
            if let task = timeEntry.task {
                HStack {
                    Text("Task")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(task.title ?? "-")
                }
            }
            if timeEntry.startDate != nil {
                DatePicker(
                    selection: $startDate,
                    displayedComponents: [.hourAndMinute]
                ) {
                    Text("Start Date")
                        .foregroundColor(.secondary)
                }
            } else {
                HStack {
                    Text("Start Date")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("--:--")
                }
            }
            if timeEntry.endDate != nil {
                DatePicker(
                    selection: $endDate,
                    displayedComponents: [.hourAndMinute]
                ) {
                    Text("End Date")
                        .foregroundColor(.secondary)
                }
            } else {
                HStack {
                    Text("End Date")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("--:--")
                }
            }
            HStack {
                Text("Duration")
                    .foregroundColor(.secondary)
                Spacer()
                if timeEntry.startDate != nil && timeEntry.endDate != nil && startDate < endDate {
                    Text(formattedDuration(startDate: startDate, endDate: endDate))
                } else {
                    Text("--:--:--")
                }
            }
            .onChange(of: startDate) { newValue in
                let calendar = Calendar.current
                let newComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                var oldComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: timeEntry.startDate!)
                
                oldComponents.hour = newComponents.hour
                oldComponents.minute = newComponents.minute
                
                if let newDate = calendar.date(from: oldComponents) {
                    startDate = newDate
                }
            }
            .onChange(of: endDate) { newValue in
                let calendar = Calendar.current
                let newComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                var oldComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: timeEntry.endDate!)
                
                oldComponents.hour = newComponents.hour
                oldComponents.minute = newComponents.minute
                
                if let newDate = calendar.date(from: oldComponents) {
                    endDate = newDate
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Entry")
        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: Button("Save") {
                if timeEntry.startDate != nil {
                    timeEntry.startDate = startDate
                }
                if timeEntry.endDate != nil {
                    timeEntry.endDate = endDate
                }

                PersistenceController.shared.saveContext()

                presentationMode.wrappedValue.dismiss()
            }
        )
    }
    
    private func formattedDuration(startDate: Date, endDate: Date) -> String {
        let dateInterval = DateInterval(start: startDate, end: endDate)
        let durationString = DataFormatter.formattedDuration(duration: dateInterval.duration)
        
        return durationString
    }
}

struct ModifyTimeEntryView_Previews: PreviewProvider {
    static var task: Task {
        let task = Task(context: PersistenceController.preview.container.viewContext)
        task.id = UUID()
        task.title = "The Task"
        task.userOrder = Int64(1)

        return task
    }

    static var timeEntry: TimeEntry {
        let timeEntry = TimeEntry(context: PersistenceController.preview.container.viewContext)
        timeEntry.id = UUID()
        timeEntry.startDate = Date(timeIntervalSinceNow: -1234)
        timeEntry.endDate = Date()
        timeEntry.task = task

        return timeEntry
    }
    
    static var previews: some View {
        ModifyTimeEntryView(timeEntry: timeEntry)
    }
}
