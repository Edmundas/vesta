//
//  ModifyTaskViewModel.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-24.
//

import Foundation

final class ModifyTaskViewModel: ObservableObject {
    @Published var task: CDTask?
    @Published var title = ""
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func save() {
        guard !title.isEmpty else { return }
        if let currentTask = task {
            dataManager.updateTask(currentTask, title: title)
        } else {
            dataManager.createTask(title: title)
        }
    }
}
