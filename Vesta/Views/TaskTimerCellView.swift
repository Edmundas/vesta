//
//  TaskTimerCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TaskTimerCellView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.editMode) var editMode
    
    @FetchRequest(
        entity: TimeEntry.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "endDate == %@", 0)
    ) var activeTimeEntries: FetchedResults<TimeEntry>
    
    @ObservedObject var task: Task
    
    @State private var timeEntry: TimeEntry?
    @State private var timer: Timer?
    @State private var secondsElapsed = 0.0
    @State private var showingEditTaskSheet = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title ?? "")
                    .font(.headline)
                    .padding(.bottom, 2.0)
                
                Text(DataFormatter.formattedDuration(duration: duration(timeEntries: task.timeEntries) + secondsElapsed))
                    .font(.subheadline)
            }
            Spacer()
            if editMode?.wrappedValue.isEditing ?? true {
                Button(action: {
                    showingEditTaskSheet = true
                }, label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.accentColor)
                })
                .buttonStyle(PlainButtonStyle())
            } else {
                Button(action: {
                    let currentDate = Date()
                    
                    if timeEntry?.startDate != nil && timeEntry?.endDate == nil {
                        stopTimer()
                        
                        timeEntry!.endDate = currentDate
                        timeEntry = nil
                    } else {
                        // Stop any running time entry
                        for activeTimeEntry in activeTimeEntries {
                            activeTimeEntry.endDate = currentDate
                        }
                        
                        startTimer()
                        
                        timeEntry = TimeEntry(context: managedObjectContext)
                        timeEntry!.id = UUID()
                        timeEntry!.startDate = currentDate
                        timeEntry!.task = task
                    }
                    
                    PersistenceController.shared.saveContext()
                }, label: {
                    Image(systemName: timeEntry?.startDate != nil ? "stop.circle.fill" : "play.circle.fill")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 44.0, height: 44.0)
                        .foregroundColor(timeEntry?.startDate != nil ? .red : .accentColor)
                })
            }
        }
        .padding(.vertical)
        .onChange(of: timeEntry?.endDate) { date in
            if date != nil {
                stopTimer()
                
                timeEntry = nil
            }
        }
        .sheet(isPresented: $showingEditTaskSheet) {
            NavigationView {
                ModifyTaskView(task: task)
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
    
    private func duration(timeEntries: Set<TimeEntry>?) -> Double {
        var dur = 0.0
        
        for timeEntry in timeEntries ?? Set<TimeEntry>() {
            if let startDate = timeEntry.startDate {
                if let endDate = timeEntry.endDate {
                    let durInterval = DateInterval(start: startDate, end: endDate)
                    dur += durInterval.duration
                }
            }
        }
        
        return dur
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            secondsElapsed += 1
        })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        secondsElapsed = 0.0
    }
}

struct TaskView_Previews: PreviewProvider {
    static var task: Task {
        let x = Task(context: PersistenceController.preview.container.viewContext)
        x.id = UUID()
        x.title = "Task title"
        x.userOrder = Int64(1)
        return x
    }
    
    static var previews: some View {
        TaskTimerCellView(task: task)
            .previewLayout(.sizeThatFits)
    }
}
