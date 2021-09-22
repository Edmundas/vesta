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
            NSSortDescriptor(keyPath: \TimeEntry.startDate, ascending: true),
            NSSortDescriptor(keyPath: \TimeEntry.task?.userOrder, ascending: true)
        ]
    ) var timeEntries: FetchedResults<TimeEntry>
    
    var body: some View {
        List {
            if timeEntries.isEmpty {
                Label("The list is empty", systemImage: "exclamationmark.circle")
            }
            ForEach (timeEntries) { timeEntry in
                TimeEntryCellView(task: timeEntry.task ?? Task(context: managedObjectContext), timeEntry: timeEntry)
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
    static var persistanceController = PersistenceController.preview
    
    static var previews: some View {
        TimeEntriesView()
            .environment(\.managedObjectContext, persistanceController.container.viewContext)
    }
}
