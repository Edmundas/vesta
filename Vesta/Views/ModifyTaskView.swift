//
//  AddTaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct ModifyTaskView: View {
    @Binding var task: Task?
    
    let completion: (() -> Void)?
    
    @State private var isNewTaskEmpty = true
    @State private var taskTitle: String
    
    init(task: Binding<Task?>, completion: (() -> Void)? = nil) {
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
            if var _ = task {
                task!.title = taskTitle
            } else {
                task = Task(title: taskTitle)
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
