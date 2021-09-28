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
    
    var task: CDTask? {
        didSet {
            if let newTask = task {
                if !taskRunning {
                    for timeEntry in newTask.timeEntries ?? Set<CDTimeEntry>() {
                        if timeEntry.endDate == nil {
                            secondsElapsed = DateInterval(start: timeEntry.startDate, end: Date()).duration
                            
                            taskTimer = TaskTimer.shared
                            taskTimer!.start()
                            
                            let nc = NotificationCenter.default
                            nc.addObserver(self, selector: #selector(timerFired), name: Notification.Name("TimerFired"), object: nil)
                            nc.addObserver(self, selector: #selector(timerEnded), name: Notification.Name("TimerEnded"), object: nil)
                            
                            taskRunning = true
                        }
                    }
                }
                
                duration = durationForTask(newTask) + secondsElapsed
            } else {
                duration = 0.0
            }
        }
    }
    
    private let dataManager: DataManagerProtocol
    private var taskTimer: TaskTimer?
    private var secondsElapsed = 0.0
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func startTask() {
        if let currentTask = task {
            dataManager.endRunningTimeEntry()
            dataManager.createTimeEntry(task: currentTask)
            
            taskTimer = TaskTimer.shared
            taskTimer!.start()
            
            let nc = NotificationCenter.default
            nc.addObserver(self, selector: #selector(timerFired), name: Notification.Name("TimerFired"), object: nil)
            nc.addObserver(self, selector: #selector(timerEnded), name: Notification.Name("TimerEnded"), object: nil)
            
            taskRunning = true
        }
    }
    
    func stopTask() {
        dataManager.endRunningTimeEntry()
        
        taskTimer!.stop()
    }
    
    @objc private func timerFired() {
        duration += 1
        secondsElapsed += 1
    }
    
    @objc private func timerEnded() {
        NotificationCenter.default.removeObserver(self)
        
        taskRunning = false
        secondsElapsed = 0.0
    }
    
    private func durationForTask(_ task: CDTask) -> Double {
        var dur = 0.0
        
        for timeEntry in task.timeEntries ?? Set<CDTimeEntry>() {
            if let endDate = timeEntry.endDate {
                let durInterval = DateInterval(start: timeEntry.startDate, end: endDate)
                dur += durInterval.duration
            }
        }
        
        return dur
    }
}
