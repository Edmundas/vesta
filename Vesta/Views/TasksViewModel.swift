//
//  TasksViewModel.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-24.
//

import Foundation

final class TasksViewModel: ObservableObject {
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func delete(task: CDTask) {
        dataManager.deleteTask(task)
    }
    
    func reorder(task: CDTask, userOrder: Int) {
        dataManager.updateTask(task, userOrder: userOrder)
    }
}
