//
//  Persistence+Preview.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-24.
//

import Foundation
import CoreData

extension PersistenceController {
    static func addPreviewData(context: NSManagedObjectContext) {
        for taskIndex in 0..<5 {
            let newTask = CDTask(context: context)
            newTask.title = "Task #\(taskIndex + 1)"
            newTask.userOrder = Int16(taskIndex + 1)
            
            for entryIndex in 0..<2 {
                let startTimeInterval = -(300.0 * Double(taskIndex + 1 + entryIndex + 1))
                let endTimeInterval = startTimeInterval + 60.0 * Double(taskIndex + 1 + entryIndex + 1)
                
                let newTimeEntry = CDTimeEntry(context: context)
                newTimeEntry.startDate = Date(timeIntervalSinceNow: startTimeInterval)
                newTimeEntry.endDate = Date(timeIntervalSinceNow: endTimeInterval)
                newTimeEntry.task = newTask
            }
        }
    }
}
