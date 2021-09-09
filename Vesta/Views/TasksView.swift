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
    
    @State private var showingAddTaskSheet = false
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("The list is empty", systemImage: "exclamationmark.circle")
            }
            ForEach(tasks) { task in
                // TODO: task cell ???
                Text(task.title ?? "")
            }
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
        .navigationBarItems(trailing: Button(action: { showingAddTaskSheet = true },
                                             label: { Image(systemName: "plus") }))
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
