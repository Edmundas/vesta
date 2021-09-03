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
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksViewModel)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active { tasksViewModel.load() }
            if phase == .inactive { tasksViewModel.save() }
        }
    }
}
