//
//  ContentView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TasksView: View {
    @State private var isPresented = false
    @State private var title: String = ""
    
    let tasks: [Task]
    
    var body: some View {
        NavigationView {
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
            .sheet(isPresented: $isPresented, content: {
                NavigationView {
                    AddTaskView(title: $title)
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                            title = ""
                        }, trailing: Button("Add") {
                            // TODO: finish implementation
                            print(title)
                            isPresented = false
                            title = ""
                        })
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(tasks: Task.data)
    }
}
