//
//  StopWatch.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-06.
//

import SwiftUI

class StopWatch: ObservableObject {
    @Published var secondsElapsed = 0.0
    @Published var mode: stopWatchMode = .stopped
    
    private var timer = Timer()
    
    enum stopWatchMode {
        case running
        case stopped
    }
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.secondsElapsed += 1
        })
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
        mode = .stopped
    }
}
