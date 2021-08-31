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
    
    @State private var isPresented = false
    @State private var title: String = ""
    
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskView(task: task)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tasks")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddTaskView(title: $title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                        title = ""
                    }, trailing: Button("Add") {
                        let newTask = Task(title: title, timeIntervals: [])
                        tasks.append(newTask)
                        isPresented = false
                        title = ""
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(tasks: .constant(previewTasks), saveAction: {})
    }
}
