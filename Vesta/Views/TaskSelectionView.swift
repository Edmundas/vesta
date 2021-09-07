//
//  TaskSelectionView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-06.
//

import SwiftUI

struct TaskSelectionView: View {
    @Binding var tasks: [Task]
    @Binding var selectedTask: Task?
    
    let completion: (() -> Void)?
    
    init(tasks: Binding<[Task]>, selectedTask: Binding<Task?>, completion: (() -> Void)? = nil) {
        self._tasks = tasks
        self._selectedTask = selectedTask
        self.completion = completion
    }
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("No tasks yet", systemImage: "exclamationmark.circle")
            }
            
            ForEach(tasks) { task in
                Button(action: {
                    selectedTask = task
                    completion?()
                }) {
                    Text(task.title)
                        .foregroundColor(.primary)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tasks")
        .navigationBarItems(leading: Button("Cancel") {
            selectedTask = nil
            completion?()
        }, trailing: Button(action: {
            // TODO: add new task
        }) { Image(systemName: "plus") })
    }
}

struct TeskSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskSelectionView(tasks: .constant(previewTasks), selectedTask: .constant(nil))
    }
}
