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
        entity: CDTask.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CDTask.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \CDTask.title, ascending: true)
        ]
    ) var tasks: FetchedResults<CDTask>
    
    @State private var editMode: EditMode = .inactive
    @State private var showingAddTaskSheet = false
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("The list is empty", systemImage: "exclamationmark.circle")
            }
            ForEach(tasks) { task in
                TaskTimerCellView(task: task)
                    .environment(\.editMode, $editMode)
                    .deleteDisabled(editMode != .active)
            }
            .onMove(perform: { from, to in
                var revisedTasks: [CDTask] = tasks.map { $0 }
                revisedTasks.move(fromOffsets: from, toOffset: to)
                
                for reverseIndex in stride(from: revisedTasks.count - 1,
                                           through: 0,
                                           by: -1) {
                    revisedTasks[reverseIndex].userOrder = Int16(reverseIndex + 1)
                }
                
                PersistenceController.shared.saveContext()
            })
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
}

struct TasksView_Previews: PreviewProvider {
    static var persistanceController = PersistenceController.preview
    
    static var previews: some View {
        TasksView()
            .environment(\.managedObjectContext, persistanceController.container.viewContext)
    }
}
