//
//  ContentView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TasksView: View {
    @Binding var tasks: [Task]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var editMode: EditMode = .inactive
    @State private var isPresented = false
    @State private var isTitleEmpty = true
    @State private var title: String = ""
    
    let saveAction: () -> Void
    
    var body: some View {
        List {
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
        .navigationBarItems(leading: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        }
        .disabled(editMode.isEditing),
                            trailing: EditButton())
        .environment(\.editMode, $editMode)
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddTaskView(title: $title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                        title = ""
                    }, trailing: Button("Add") {
                        let newTask = Task(title: title, timeIntervals: [DateInterval(start: Date(), duration: 100)])
                        tasks.append(newTask)
                        isPresented = false
                        title = ""
                    }
                    .disabled(isTitleEmpty))
                    .onChange(of: title) { newTitle in
                        isTitleEmpty = newTitle.isEmpty
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    private func binding(for task: Task) -> Binding<Task> {
        guard let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Can't find task in array.")
        }
        return $tasks[taskIndex]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(tasks: .constant(previewTasks), saveAction: {})
    }
}
