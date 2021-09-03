//
//  AddTaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct ModifyTaskView: View {
    @Binding var task: Task
    
    var body: some View {
        List {
            TextField("Title", text: $task.title)
                .modifier(ClearButton(text: $task.title))
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTaskView(task: .constant(previewTasks[0]))
    }
}
