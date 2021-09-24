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
    
    @State var timeEntry: CDTimeEntry
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    init(timeEntry: CDTimeEntry) {
        _timeEntry = State(initialValue: timeEntry)
        _startDate = State(initialValue: timeEntry.startDate)
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
                    Text(task.title)
                        .foregroundColor(.secondary)
                }
            }
            DatePicker(
                selection: $startDate,
                displayedComponents: [.hourAndMinute]
            ) {
                Text("Start Date")
                    .foregroundColor(.secondary)
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
                if timeEntry.endDate != nil && startDate < endDate {
                    Text(formattedDuration(startDate: startDate, endDate: endDate))
                        .foregroundColor(.secondary)
                } else {
                    Text("--:--:--")
                        .foregroundColor(.secondary)
                }
            }
            .onChange(of: startDate) { newValue in
                let calendar = Calendar.current
                let newComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                var oldComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: timeEntry.startDate)
                
                oldComponents.hour = newComponents.hour
                oldComponents.minute = newComponents.minute
                
                if let newDate = calendar.date(from: oldComponents) {
                    startDate = newDate
                }
            }
            .onChange(of: endDate) { newValue in
                let calendar = Calendar.current
                let newComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                var oldComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: timeEntry.endDate!)
                
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
                timeEntry.startDate = startDate
                if timeEntry.endDate != nil {
                    timeEntry.endDate = endDate
                }
                
                do {
                    try managedObjectContext.save()
                } catch {
                    // TODO: CoreData - Handle save error
                    fatalError("Unresolved error: \(error)")
                }

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
    static var task: CDTask {
        let task = CDTask(context: PersistenceController.preview.container.viewContext)
        task.title = "The Task"
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
        ModifyTimeEntryView(timeEntry: timeEntry)
    }
}
