//
//  TasksView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TasksView: View {
//    @Binding var tasks: [TaskOld]
    
//    @State private var editMode: EditMode = .inactive
//    @State private var showingAddTaskSheet = false
//    @State private var newTask: TaskOld?
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \Task.title, ascending: true)
        ]
    ) var tasksX: FetchedResults<Task>
    
    var body: some View {
        List(tasksX, id: \.self) { task in
            Text(task.title ?? "Unknown")
        }
//        List {
//            if tasks.isEmpty {
//                Label("No tasks yet", systemImage: "exclamationmark.circle")
//            }
//            ForEach(tasks) { task in
//                NavigationLink(destination: TaskDetailsView(task: binding(for: task))) {
//                    TaskCellView(task: task)
//                }
//            }
//            .onMove { from, to in
//                tasks.move(fromOffsets: from, toOffset: to)
//            }
//            .onDelete { offsets in
//                tasks.remove(atOffsets: offsets)
//            }
//        }
//        .listStyle(InsetGroupedListStyle())
//        .navigationTitle("Tasks")
//        .navigationBarItems(leading: Button(action: {
//            showingAddTaskSheet = true
//        }) { Image(systemName: "plus") }.disabled(editMode.isEditing),
//                            trailing: EditButton())
//        .environment(\.editMode, $editMode)
//        .sheet(isPresented: $showingAddTaskSheet) {
//            NavigationView {
//                ModifyTaskView(task: $newTask) {
//                    if let task = newTask {
//                        tasks.append(task)
//                    }
//                    newTask = nil
//                    showingAddTaskSheet = false
//                }
//            }
//        }
    }
    
//    private func binding(for task: TaskOld) -> Binding<TaskOld> {
//        guard let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) else {
//            fatalError("Can't find task in array.")
//        }
//        return $tasks[taskIndex]
//    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
//        TasksView(tasks: .constant(previewTasks))
        TasksView()
    }
}
