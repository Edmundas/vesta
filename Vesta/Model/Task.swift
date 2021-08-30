//
//  TimeInterval.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct Task: Identifiable {
    let id: UUID = UUID()
    var title: String
    var timeIntervals: [DateInterval]
}

extension Task {
    static var data: [Task] {
        [
            Task(title: "First Task", timeIntervals: []),
            Task(title: "Second Task", timeIntervals: [])
        ]
    }
}
