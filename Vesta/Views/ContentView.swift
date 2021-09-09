//
//  ContentView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TasksView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var persistanceController = PersistenceController.preview
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, persistanceController.container.viewContext)
    }
}
