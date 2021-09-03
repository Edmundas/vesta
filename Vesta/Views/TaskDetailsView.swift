//
//  TaskDetailsView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TaskDetailsView: View {
    @Binding var task: Task
    
    @State private var isPresented = false
    @State private var isTitleEmpty = false
    @State private var modifiedTask = Task()
    
    var body: some View {
        List {
            if task.timeIntervals.isEmpty {
                Label("No time intervals yet", systemImage: "timer")
            }
            ForEach(task.timeIntervals, id: \.self) { timeInterval in
                DateIntervalCellView(dateInterval: timeInterval)
            }
            .onDelete { offsets in
                task.timeIntervals.remove(atOffsets: offsets)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(task.title)
        .navigationBarItems(trailing: Button(action: {
            modifiedTask = task
            isPresented = true
        },
                                             label: { Text("Edit") }))
        .sheet(isPresented: $isPresented) {
            NavigationView {
                ModifyTaskView(task: $modifiedTask)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        task = modifiedTask
                        isPresented = false
                    }.disabled(isTitleEmpty))
                    .onChange(of: task.title) { newTitle in
                        isTitleEmpty = newTitle.isEmpty
                    }
            }
        }
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(task: .constant(previewTasks[0]))
    }
}
