//
//  TimerView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimerView: View {
//    @EnvironmentObject var stopWatch: StopWatch
    
//    @Binding var tasks: [TaskOld]
    
//    @State private var showingSelectTaskSheet = false
//    @State private var selectedTaskId: UUID?
    
    var body: some View {
        Text("TIMER")
//        List {
//            Section() {
//                HStack {
//                    Spacer()
//                    VStack {
//                        Text(DataFormatter.formattedDuration(duration: stopWatch.secondsElapsed))
//                            .font(.title)
//                        if let task = tasks.first(where: { $0.id == selectedTaskId }) {
//                            Spacer()
//                            Text(task.title)
//                                .font(.subheadline)
//                        }
//                    }
//                    Spacer()
//                }
//                .padding(.vertical)
//            }
//            Section() {
//                HStack {
//                    Spacer()
//                    Button(stopWatch.mode == .running ? "Stop" : "Start") {
//                        if stopWatch.mode == .stopped {
//                            showingSelectTaskSheet = true
//                        } else {
//                            if let task = tasks.first(where: { $0.id == selectedTaskId }) {
//                                let secondsElapsed = stopWatch.secondsElapsed
//                                let dateInterval = DateInterval(start: Date(timeIntervalSinceNow: -secondsElapsed), duration: secondsElapsed)
//                                if let index = tasks.firstIndex(of: task) {
//                                    tasks[index].timeIntervals.append(dateInterval)
//                                }
//                            }
//                            selectedTaskId = nil
//                            stopWatch.stop()
//                        }
//                    }
//                    .font(.title)
//                    .foregroundColor(stopWatch.mode == .running ? .red : .accentColor)
//                    Spacer()
//                }
//                .padding(.vertical)
//            }
//            Section() {
//                let (displayedTimerEntries, displayedTaskEntries) = recentTimerEntries(tasks: tasks)
//
//                if displayedTimerEntries.isEmpty {
//                    Label("No time intervals yet", systemImage: "exclamationmark.circle")
//                }
//                ForEach(displayedTimerEntries.indices, id: \.self) { i in
//                    DateIntervalCellView(dateInterval: displayedTimerEntries[i], title: displayedTaskEntries[i].title)
//                }
//                .onDelete { offsets in
//                    if let index = offsets.first {
//                        let timerEntry = displayedTimerEntries[index]
//                        let taskEntry = displayedTaskEntries[index]
//
//                        if let taskIndex = tasks.firstIndex(of: taskEntry) {
//                            if let timerIntervalIndex = tasks[taskIndex].timeIntervals.firstIndex(of: timerEntry) {
//                                tasks[taskIndex].timeIntervals.remove(at: timerIntervalIndex)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .listStyle(InsetGroupedListStyle())
//        .navigationTitle("Timer")
//        .sheet(isPresented: $showingSelectTaskSheet) {
//            NavigationView {
//                TaskSelectionView(tasks: $tasks, selectedTaskId: $selectedTaskId) {
//                    showingSelectTaskSheet = false
//                    if let _ = selectedTaskId {
//                        stopWatch.start()
//                    }
//                }
//            }
//        }
    }
    
    private func recentTimerEntries(tasks: [TaskOld]) -> ([DateInterval], [TaskOld]) {
        let numberOfEntries = 5
        var recentEntries: [DateInterval] = []
        var recentTasks: [TaskOld] = []
        
        for task in tasks {
            for timeInterval in task.timeIntervals {
                let index = recentEntries.insertionReverseIndex(of: timeInterval)
                recentEntries.insert(timeInterval, at: index)
                recentTasks.insert(task, at: index)
                if recentEntries.count > numberOfEntries {
                    recentEntries.remove(at: numberOfEntries)
                    recentTasks.remove(at: numberOfEntries)
                }
            }
        }
        
        return (recentEntries, recentTasks)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
//        TimerView(tasks: .constant(previewTasks))
        TimerView()
    }
}
