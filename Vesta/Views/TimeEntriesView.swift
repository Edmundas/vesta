//
//  TimeEntriesView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimeEntriesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: CDTimeEntry.fetchRequest())
    private var timeEntries: FetchedResults<CDTimeEntry>
    
    @StateObject private var viewModel = TimeEntriesViewModel()
    
    var body: some View {
        List {
            if timeEntries.isEmpty {
                Label("The list is empty", systemImage: "exclamationmark.circle")
            }
            ForEach (timeEntries) { timeEntry in
                TimeEntryCellView(timeEntry: timeEntry)
            }
            .onDelete(perform: deleteTimeEntry)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Entries")
    }
}

extension TimeEntriesView {
    private func deleteTimeEntry(indexSet: IndexSet) {
        for index in indexSet {
            viewModel.delete(timeEntry: timeEntries[index])
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var persistanceController = PersistenceController.preview
    
    static var previews: some View {
        TimeEntriesView()
            .environment(\.managedObjectContext, persistanceController.container.viewContext)
    }
}
