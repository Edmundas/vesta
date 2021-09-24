//
//  DataManager+Task.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-24.
//

import Foundation
import CoreData

protocol TaskDataManagerProtocol {
    func createTask(title: String)
    func updateTask(_ task: CDTask, title: String?, userOrder: Int?)
    func deleteTask(_ task: CDTask)
}

extension TaskDataManagerProtocol {
    func updateTask(_ task: CDTask, title: String? = nil, userOrder: Int? = nil) {
        updateTask(task, title: title, userOrder: userOrder)
    }
}

// MARK: - TaskDataManagerProtocol
extension DataManager: TaskDataManagerProtocol {
    func createTask(title: String) {
        context.performAndWait {
            let request: NSFetchRequest<CDTask> = CDTask.fetchRequest()
            do {
                let tasksCount = try context.count(for: request)
                let task = CDTask(context: context)
                task.title = title
                task.userOrder = Int16(tasksCount + 1)
                
                try context.save()
            } catch {
                // TODO: CoreData - Handle error
                fatalError("Unresolved error: \(error)")
            }
        }
    }
    
    func updateTask(_ task: CDTask, title: String?, userOrder: Int?) {
        context.performAndWait {
            do {
                if let newTitle = title {
                    task.title = newTitle
                }
                if let newUserOrder = userOrder {
                    task.userOrder = Int16(newUserOrder)
                }
                
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                // TODO: CoreData - Handle error
                fatalError("Unresolved error: \(error)")
            }
        }
    }
    
    func deleteTask(_ task: CDTask) {
        context.performAndWait {
            do {
                context.delete(task)
                
                try context.save()
            } catch {
                // TODO: CoreData - Handle error
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
