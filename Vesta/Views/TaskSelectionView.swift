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
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("No tasks yet", systemImage: "exclamationmark.circle")
            }
            
            ForEach(tasks) { task in
                Button(action: {
                    selectedTask = task
                }) {
                    Text(task.title)
                        .foregroundColor(.primary)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tasks")
    }
}

struct TeskSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskSelectionView(tasks: .constant(previewTasks), selectedTask: .constant(nil))
    }
}
