//
//  DataManager+TimeEntry.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-24.
//

import Foundation
import CoreData

protocol TimeEntryDataManagerProtocol {
    func createTimeEntry(task: CDTask)
    func endRunningTimeEntry()
}

// MARK: - TimeEntryDataManagerProtocol
extension DataManager: TimeEntryDataManagerProtocol {
    func createTimeEntry(task: CDTask) {
        context.performAndWait {
            do {
                let timeEntry = CDTimeEntry(context: context)
                timeEntry.task = task
                
                try context.save()
            } catch {
                // TODO: CoreData - Handle error
                fatalError("Unresolved error: \(error)")
            }
        }
    }
    
    func endRunningTimeEntry() {
        context.performAndWait {
            let request: NSFetchRequest<CDTimeEntry> = CDTimeEntry.fetchRequestRunning()
            request.fetchLimit = 1
            do {
                let timeEntry = try context.fetch(request).first
                timeEntry?.endDate = Date()
                
                try context.save()
            } catch {
                // TODO: CoreData - Handle error
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}

