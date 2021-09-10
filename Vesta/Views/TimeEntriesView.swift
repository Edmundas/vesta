//
//  TimeEntriesView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimeEntriesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: TimeEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \TimeEntry.task?.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \TimeEntry.startDate, ascending: true)
        ]
    ) var timeEntries: FetchedResults<TimeEntry>
    
    var body: some View {
        List {
            ForEach (timeEntries) { timeEntry in
                VStack(alignment: .leading) {
                    if let task = timeEntry.task {
                        Text(task.title ?? "")
                            .font(.headline)
                            .padding(.bottom, 2.0)
                    }
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
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    let timeEntry = timeEntries[index]
                    managedObjectContext.delete(timeEntry)
                }
                
                PersistenceController.shared.saveContext()
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Entries")
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimeEntriesView()
    }
}
