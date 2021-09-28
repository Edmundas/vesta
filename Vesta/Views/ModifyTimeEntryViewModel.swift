//
//  ModifyTimeEntryViewModel.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-28.
//

import Foundation

final class ModifyTimeEntryViewModel: ObservableObject {
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    var timeEntry: CDTimeEntry? {
        didSet {
            if let newTimeEntry = timeEntry {
                startDate = newTimeEntry.startDate
                if let newEndDate = newTimeEntry.endDate {
                    endDate = newEndDate
                }
            } else {
                startDate = Date()
                endDate = Date()
            }
        }
    }
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func save() {
        if let currentTimeEntry = timeEntry {
            dataManager.updateTimeEntry(currentTimeEntry, startDate: startDate, endDate: endDate)
        }
    }
    
}
