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
                    Text(DataFormatter.formattedDuration(duration: stopWatch.secondsElapsed))
                        .font(.title)
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
                let (timeEntries, titleEntries) = recentEntries(tasks: tasks)
                
                ForEach(timeEntries, id: \.self) { dateInterval in
                    DateIntervalCellView(dateInterval: dateInterval, title: titleEntries[timeEntries.firstIndex(of: dateInterval)!])
                }
                .onDelete { offsets in
                    // TODO: delete time entries
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
                    }, trailing: Button(action: {
                        // TODO: add task action
                    } ) { Image(systemName: "plus") }
                    .disabled(true))
                    .onChange(of: selectedTask) { newSelectedTask in
                        showingSelectTaskSheet = false
                        stopWatch.start()
                    }
            }
        }
    }
    
    private func recentEntries(tasks: [Task]) -> ([DateInterval], [String]) {
        let numberOfEntries = 5
        var timeEntries: [DateInterval] = []
        var titleEntries: [String] = []
        
        for task in tasks {
            for timeInterval in task.timeIntervals {
                let index = timeEntries.insertionReverseIndex(of: timeInterval)
                timeEntries.insert(timeInterval, at: index)
                titleEntries.insert(task.title, at: index)
                if timeEntries.count > numberOfEntries {
                    timeEntries.remove(at: numberOfEntries)
                    titleEntries.remove(at: numberOfEntries)
                }
            }
        }
        
        return (timeEntries, titleEntries)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(tasks: .constant(previewTasks))
    }
}
