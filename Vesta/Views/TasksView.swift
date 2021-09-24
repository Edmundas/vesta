//
//  TasksView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TasksView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: CDTask.fetchRequest())
    private var tasks: FetchedResults<CDTask>
    
    @StateObject private var viewModel = TasksViewModel()
    
    @State private var editMode: EditMode = .inactive
    @State private var showingAddTaskSheet = false
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("The list is empty", systemImage: "exclamationmark.circle")
            }
            ForEach(tasks) { task in
                TaskCellView(task: task)
                    .environment(\.editMode, $editMode)
                    .deleteDisabled(editMode != .active)
            }
            .onMove(perform: moveTask)
            .onDelete(perform: deleteTask)
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
            }
        }
    }
}

extension TasksView {
    private func moveTask(from source: IndexSet, to destination: Int) {
        var revisedTasks: [CDTask] = tasks.map { $0 }
        revisedTasks.move(fromOffsets: source, toOffset: destination)
        
        // update order in data model
        for reverseIndex in stride(from: revisedTasks.count - 1, through: 0, by: -1) {
            viewModel.reorder(task: revisedTasks[reverseIndex], userOrder: reverseIndex + 1)
        }
    }
    
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            viewModel.delete(task: tasks[index])
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
