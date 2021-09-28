//
//  TimeEntryCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimeEntryCellView: View {
    @ObservedObject var timeEntry: CDTimeEntry
    
    @State private var showingEditTimeEntrySheet = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timeEntry.task?.title ?? "")
                    .font(.headline)
                    .padding(.vertical, 4.0)
                HStack {
                    Group {
                        Text(timeEntry.isFault
                             ? "-"
                             : DataFormatter.formattedMonthDay(date: timeEntry.startDate))
                        Text(" | ")
                        Text(timeEntry.isFault || timeEntry.endDate == nil
                             ? "-"
                             : DataFormatter.formattedTimeInterval(startDate: timeEntry.startDate, endDate: timeEntry.endDate!))
                        Text(" | ")
                    }
                    .foregroundColor(.secondary)
                    Text(timeEntry.isFault || timeEntry.endDate == nil
                         ? "-"
                         : DataFormatter.formattedDuration(startDate: timeEntry.startDate, endDate: timeEntry.endDate!))
                }
                .font(.subheadline)
                .padding(.bottom, 2.0)
            }
            Spacer()
            Button(action: {
                showingEditTimeEntrySheet = true
            }, label: {
                Image(systemName: "pencil")
                    .foregroundColor(.accentColor)
            })
            .buttonStyle(PlainButtonStyle())
            .disabled(timeEntry.endDate == nil)
        }
        .sheet(isPresented: $showingEditTimeEntrySheet) {
            NavigationView {
                ModifyTimeEntryView(timeEntry: timeEntry)
            }
        }
        .deleteDisabled(timeEntry.endDate == nil)
    }
}

struct DateIntervalCellView_Previews: PreviewProvider {
    static var task: CDTask {
        let task = CDTask(context: PersistenceController.preview.container.viewContext)
        task.title = "Task title"
        task.userOrder = Int16(1)
        
        return task
    }
    
    static var timeEntry: CDTimeEntry {
        let timeEntry = CDTimeEntry(context: PersistenceController.preview.container.viewContext)
        timeEntry.startDate = Date(timeIntervalSinceNow: -1234)
        timeEntry.endDate = Date()
        timeEntry.task = task
        
        return timeEntry
    }
    
    static var previews: some View {
        TimeEntryCellView(timeEntry: timeEntry)
            .previewLayout(.sizeThatFits)
    }
}
