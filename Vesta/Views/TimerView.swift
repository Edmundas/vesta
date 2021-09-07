//
//  TimerView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var stopWatch = StopWatch()
    
    @Binding var tasks: [Task]
    
    @State private var showingSelectTaskSheet = false
    @State private var selectedTask: Task?
    
    var body: some View {
        List {
            Section() {
                HStack {
                    Spacer()
                    VStack {
                        Text(DataFormatter.formattedDuration(duration: stopWatch.secondsElapsed))
                            .font(.title)
                        if let title = selectedTask?.title {
                            Spacer()
                            Text(title)
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical)
            }
            Section() {
                HStack {
                    Spacer()
                    Button(stopWatch.mode == .running ? "Stop" : "Start") {
                        if stopWatch.mode == .stopped {
                            showingSelectTaskSheet = true
                        } else {
                            if let task = selectedTask {
                                let secondsElapsed = stopWatch.secondsElapsed
                                let dateInterval = DateInterval(start: Date(timeIntervalSinceNow: -secondsElapsed), duration: secondsElapsed)
                                if let index = tasks.firstIndex(of: task) {
                                    tasks[index].timeIntervals.append(dateInterval)
                                }
                            }
                            selectedTask = nil
                            stopWatch.stop()
                        }
                    }
                    .font(.title)
                    .foregroundColor(stopWatch.mode == .running ? .red : .accentColor)
                    Spacer()
                }
                .padding(.vertical)
            }
            Section() {
                if tasks.isEmpty {
                    Label("No tasks yet", systemImage: "exclamationmark.circle")
                }
                
                let (displayedTimerEntries, displayedTaskEntries) = recentTimerEntries(tasks: tasks)
                
                ForEach(displayedTimerEntries.indices, id: \.self) { i in
                    DateIntervalCellView(dateInterval: displayedTimerEntries[i], title: displayedTaskEntries[i].title)
                }
                .onDelete { offsets in
                    if let index = offsets.first {
                        let timerEntry = displayedTimerEntries[index]
                        let taskEntry = displayedTaskEntries[index]
                        
                        if let taskIndex = tasks.firstIndex(of: taskEntry) {
                            if let timerIntervalIndex = tasks[taskIndex].timeIntervals.firstIndex(of: timerEntry) {
                                tasks[taskIndex].timeIntervals.remove(at: timerIntervalIndex)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Timer")
        .sheet(isPresented: $showingSelectTaskSheet) {
            NavigationView {
                TaskSelectionView(tasks: $tasks, selectedTask: $selectedTask)
                    .navigationBarItems(leading: Button("Cancel") {
                        showingSelectTaskSheet = false
                        selectedTask = nil
                    })
                    .onChange(of: selectedTask) { newSelectedTask in
                        showingSelectTaskSheet = false
                        stopWatch.start()
                    }
            }
        }
    }
    
    private func recentTimerEntries(tasks: [Task]) -> ([DateInterval], [Task]) {
        let numberOfEntries = 5
        var recentEntries: [DateInterval] = []
        var recentTasks: [Task] = []
        
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
        TimerView(tasks: .constant(previewTasks))
    }
}
