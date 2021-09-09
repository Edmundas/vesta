//
//  ContentView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var tasksViewModel: TasksViewModel
    
    @State private var selection: Tab = .timer
    
    enum Tab {
        case timer
        case tasks
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
//                TimerView(tasks: $tasksViewModel.tasks)
                TimerView()
            }
            .tabItem {
                Label("Timer", systemImage: "clock")
            }
            .tag(Tab.timer)
            
            NavigationView {
//                TasksView(tasks: $tasksViewModel.tasks)
                TasksView()
            }
            .tabItem {
                Label("Tasks", systemImage: "folder")
            }
            .tag(Tab.tasks)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
