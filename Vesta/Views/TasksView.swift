//
//  TasksView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TasksView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \Task.title, ascending: true)
        ]
    ) var tasks: FetchedResults<Task>
    
//    @FetchRequest(
//        entity: TimeEntry.entity(),
//        sortDescriptors: []
//    ) var timeEntries: FetchedResults<TimeEntry>
    
    @State private var editMode: EditMode = .inactive
    @State private var showingAddTaskSheet = false
    
    var body: some View {
//        let _ = deleteAllTimeEntries()
        List {
            if tasks.isEmpty {
                Label("The list is empty", systemImage: "exclamationmark.circle")
            }
            ForEach(tasks) { task in
                TaskTimerCellView(task: task)
                    .environment(\.editMode, $editMode)
            }
//            .onMove(perform: { from, to in
//                // TODO: implement task reorder
//                print("MOVE TASK")
//            })
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    let task = tasks[index]
                    managedObjectContext.delete(task)
                }

                PersistenceController.shared.saveContext()
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tasks")
        .navigationBarItems(leading: EditButton(),
                            trailing: Button(action: { showingAddTaskSheet = true },
                                             label: { Image(systemName: "plus") }))
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $showingAddTaskSheet) {
            NavigationView {
                ModifyTaskView()
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
    
//    private func deleteAllTimeEntries() {
//        for timeEntry in timeEntries {
//            managedObjectContext.delete(timeEntry)
//        }
//
//        PersistenceController.shared.saveContext()
//    }
}

struct TasksView_Previews: PreviewProvider {
    static var persistanceController = PersistenceController.preview
    
    static var previews: some View {
        TasksView()
            .environment(\.managedObjectContext, persistanceController.container.viewContext)
    }
}
