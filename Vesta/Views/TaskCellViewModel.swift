//
//  TaskCellViewModel.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-24.
//

import Foundation

final class TaskCellViewModel: ObservableObject {
    @Published var taskRunning = false
    @Published var duration = 0.0
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func start(task: CDTask) {
        taskRunning = true
    }
    
    func stop(task: CDTask) {
        taskRunning = false
    }
}
