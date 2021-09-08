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
    @ObservedObject var stopWatch = StopWatch()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksViewModel)
                .environmentObject(stopWatch)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active { tasksViewModel.load() }
            if phase == .inactive { tasksViewModel.save() }
        }
    }
}
