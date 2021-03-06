//
//  VestaApp.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

@main
struct VestaApp: App {
    @State private var selection: Tab = .tasks
        
    enum Tab {
        case tasks
        case timeEntries
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                NavigationView {
                    TasksView()
                }
                .navigationViewStyle(.stack)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem {
                    Label("Tasks", systemImage: "list.triangle")
                }
                .tag(Tab.tasks)
                
                NavigationView {
                    TimeEntriesView()
                }
                .navigationViewStyle(.stack)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem {
                    Label("Entries", systemImage: "clock")
                }
                .tag(Tab.timeEntries)
            }
        }
    }
}
