//
//  AddTaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct ModifyTaskView: View {
    @Binding var task: TaskOld?
    
    let completion: (() -> Void)?
    
    @State private var isNewTaskEmpty = true
    @State private var taskTitle: String
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    init(task: Binding<TaskOld?>, completion: (() -> Void)? = nil) {
        self._task = task
        self.completion = completion
        self._taskTitle = State.init(wrappedValue: task.wrappedValue?.title ?? "")
    }
    
    var body: some View {
        List {
            TextField("Title", text: $taskTitle)
                .modifier(ClearButton(text: $taskTitle))
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Task")
        .onChange(of: taskTitle) { newTitle in
            isNewTaskEmpty = newTitle.isEmpty
        }
        .navigationBarItems(leading: Button("Cancel") {
            completion?()
        }, trailing: Button("Save") {
            let taskX = Task(context: managedObjectContext)
            taskX.id = UUID()
            taskX.title = taskTitle
            PersistenceController.shared.saveContext()
            
            if var _ = task {
                task!.title = taskTitle
            } else {
                task = TaskOld(title: taskTitle)
            }
            completion?()
        }
        .disabled(isNewTaskEmpty))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTaskView(task: .constant(previewTasks[0]))
    }
}
