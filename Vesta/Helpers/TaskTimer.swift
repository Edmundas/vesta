//
//  TaskTimer.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-27.
//

import Foundation

final class TaskTimer: ObservableObject {
    static let shared = TaskTimer()
    
    private var timer: Timer?
    
    func start() {
        if timer != nil {
            stop()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            NotificationCenter.default.post(name: Notification.Name("TimerFired"), object: nil)
        })
    }
    
    func stop() {
        NotificationCenter.default.post(name: Notification.Name("TimerEnded"), object: nil)
        
        timer?.invalidate()
        timer = nil
    }
}
