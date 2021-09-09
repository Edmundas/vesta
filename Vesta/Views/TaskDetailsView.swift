//
//  TaskDetailsView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TaskDetailsView: View {
    @Binding var task: TaskOld
    
    @State private var showingModifyTaskSheet = false
    
    var body: some View {
        List {
            if task.timeIntervals.isEmpty {
                Label("No time intervals yet", systemImage: "exclamationmark.circle")
            }
            ForEach(task.timeIntervals, id: \.self) { timeInterval in
                DateIntervalCellView(dateInterval: timeInterval, title: nil)
            }
            .onDelete { offsets in
                task.timeIntervals.remove(atOffsets: offsets)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(task.title)
        .navigationBarItems(trailing: Button(action: {
            showingModifyTaskSheet = true
        }, label: { Text("Edit") }))
        .sheet(isPresented: $showingModifyTaskSheet) {
            NavigationView {
                ModifyTaskView(task: Binding.init($task)) {
                    showingModifyTaskSheet = false
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
