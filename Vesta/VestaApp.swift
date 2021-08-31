//
//  VestaApp.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

@main
struct VestaApp: App {
    @ObservedObject var tasksViewModel = TasksViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TasksView(tasks: $tasksViewModel.tasks) {
                    tasksViewModel.save()
                }
            }
            .onAppear {
                tasksViewModel.load()
            }
        }
    }
}
