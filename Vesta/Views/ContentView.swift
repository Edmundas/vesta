//
//  ContentView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var tasksViewModel: TasksViewModel
    
    @State private var selection: Tab = .timer
    
    enum Tab {
        case timer
        case tasks
    }
    
    var body: some View {
        TabView(selection: $selection) {
            TimerView(tasks: $tasksViewModel.tasks)
                .tabItem {
                    Label("Timer", systemImage: "clock")
                }
                .tag(Tab.timer)
            
            NavigationView {
                TasksView(tasks: $tasksViewModel.tasks)
            }
            .navigationViewStyle(StackNavigationViewStyle())
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
