//
//  TimeEntriesViewModel.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-27.
//

import Foundation

final class TimeEntriesViewModel: ObservableObject {
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func delete(timeEntry: CDTimeEntry) {
        dataManager.deleteTimeEntry(timeEntry)
    }
}
