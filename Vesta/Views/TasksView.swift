//
//  TasksView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TasksView: View {
    @Binding var tasks: [Task]
    
    @State private var editMode: EditMode = .inactive
    @State private var showingAddTaskSheet = false
    @State private var isNewTaskEmpty = true
    @State private var newTask = Task()
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("No tasks yet", systemImage: "exclamationmark.circle")
            }
            ForEach(tasks) { task in
                NavigationLink(destination: TaskDetailsView(task: binding(for: task))) {
                    TaskCellView(task: task)
                }
            }
            .onMove { from, to in
                tasks.move(fromOffsets: from, toOffset: to)
            }
            .onDelete { offsets in
                tasks.remove(atOffsets: offsets)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tasks")
        .navigationBarItems(leading: Button(action: { showingAddTaskSheet = true }) { Image(systemName: "plus") }.disabled(editMode.isEditing),
                            trailing: EditButton())
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $showingAddTaskSheet) {
            NavigationView {
                ModifyTaskView(task: $newTask)
                    .navigationBarItems(leading: Button("Cancel") {
                        newTask = Task()
                        showingAddTaskSheet = false
                    }, trailing: Button("Add") {
                        tasks.append(newTask)
                        newTask = Task()
                        showingAddTaskSheet = false
                    }
                    .disabled(isNewTaskEmpty))
                    .onChange(of: newTask.title) { newTitle in
                        isNewTaskEmpty = newTitle.isEmpty
                    }
            }
        }
    }
    
    private func binding(for task: Task) -> Binding<Task> {
        guard let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Can't find task in array.")
        }
        return $tasks[taskIndex]
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(tasks: .constant(previewTasks))
    }
}
