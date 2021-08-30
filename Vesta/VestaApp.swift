//
//  VestaApp.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

@main
struct VestaApp: App {
    var body: some Scene {
        WindowGroup {
            TasksView(tasks: Task.data)
        }
    }
}
