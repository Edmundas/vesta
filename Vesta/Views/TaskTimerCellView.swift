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
        entity: CDTimeEntry.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "endDate == %@", 0)
    ) var activeTimeEntries: FetchedResults<CDTimeEntry>
    
    @ObservedObject var task: CDTask
    
    @State private var timeEntry: CDTimeEntry?
    @State private var timer: Timer?
    @State private var secondsElapsed = 0.0
    @State private var showingEditTaskSheet = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
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
                    if timeEntry != nil && timeEntry!.endDate == nil {
                        stopTimer()
                        
                        timeEntry!.endDate = Date()
                        timeEntry = nil
                    } else {
                        timeEntry = CDTimeEntry(context: managedObjectContext)
                        timeEntry!.task = task
                        
                        // Stop any running time entry
                        for activeTimeEntry in activeTimeEntries {
                            activeTimeEntry.endDate = timeEntry!.startDate
                        }
                        
                        startTimer()
                    }
                    
                    do {
                        try managedObjectContext.save()
                    } catch {
                        // TODO: CoreData - Handle save error
                        fatalError("Unresolved error: \(error)")
                    }
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
    
    private func duration(timeEntries: Set<CDTimeEntry>?) -> Double {
        var dur = 0.0
        
        for timeEntry in timeEntries ?? Set<CDTimeEntry>() {
            if let endDate = timeEntry.endDate {
                let durInterval = DateInterval(start: timeEntry.startDate, end: endDate)
                dur += durInterval.duration
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
    static var task: CDTask {
        let task = CDTask(context: PersistenceController.preview.container.viewContext)
        task.title = "Task title"
        task.userOrder = Int16(1)
        
        return task
    }
    
    static var previews: some View {
        TaskTimerCellView(task: task)
            .previewLayout(.sizeThatFits)
    }
}
