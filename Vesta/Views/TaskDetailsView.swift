//
//  TaskDetailsView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TaskDetailsView: View {
    @Binding var task: Task
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        List {
            Section(header: Text("Time intervals")) {
                if task.timeIntervals.isEmpty {
                    Label("No time intervals yet", systemImage: "timer")
                }
                ForEach(task.timeIntervals, id: \.self) { timeInterval in
                    Text(timeInterval.description)
                }
                .onDelete { offsets in
                    task.timeIntervals.remove(atOffsets: offsets)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(task.title)
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $editMode)
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(task: .constant(previewTasks[0]))
    }
}
