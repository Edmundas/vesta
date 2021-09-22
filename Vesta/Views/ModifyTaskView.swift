//
//  ModifyTaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct ModifyTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: []
    ) var tasks: FetchedResults<Task>
    
    @State var task: Task?
    @State private var taskTitle = ""
    
    init(task: Task? = nil) {
        _task = State(initialValue: task)
        _taskTitle = State(initialValue: task?.title ?? "")
    }
    
    var body: some View {
        List {
            TextField("Title", text: $taskTitle)
                .modifier(ClearButton(text: $taskTitle))
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Task")
        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: Button("Save") {
                if let existingTask = task {
                    existingTask.title = taskTitle
                } else {
                    let task = Task(context: managedObjectContext)
                    task.title = taskTitle
                    task.userOrder = Int16(tasks.count + 1)
                }
                
                PersistenceController.shared.saveContext()
                
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(taskTitle.isEmpty)
        )
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTaskView()
    }
}
