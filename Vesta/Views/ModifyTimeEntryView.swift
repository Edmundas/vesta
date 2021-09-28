//
//  ModifyTimeEntryView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct ModifyTimeEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = ModifyTimeEntryViewModel()
    
    var timeEntry: CDTimeEntry
    
    var body: some View {
        List {
            if let task = timeEntry.task {
                HStack {
                    Text("Task")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(task.title)
                        .foregroundColor(.secondary)
                }
            }
            DatePicker(
                selection: $viewModel.startDate,
                in: ...viewModel.endDate,
                displayedComponents: [.hourAndMinute]
            ) {
                Text("Start Date")
                    .foregroundColor(.secondary)
            }
            if timeEntry.endDate != nil {
                DatePicker(
                    selection: $viewModel.endDate,
                    in: viewModel.startDate...,
                    displayedComponents: [.hourAndMinute]
                ) {
                    Text("End Date")
                        .foregroundColor(.secondary)
                }
            } else {
                HStack {
                    Text("End Date")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("-")
                }
            }
            HStack {
                Text("Duration")
                    .foregroundColor(.secondary)
                Spacer()
                if timeEntry.endDate != nil {
                    Text(DataFormatter.formattedDuration(startDate: viewModel.startDate, endDate: viewModel.endDate))
                        .foregroundColor(.secondary)
                } else {
                    Text("-")
                        .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Entry")
        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: Button("Save") {
                viewModel.save()
                presentationMode.wrappedValue.dismiss()
            }
        )
        .onAppear(perform: prepareViewModel)
    }
}

extension ModifyTimeEntryView {
    private func prepareViewModel() {
        viewModel.timeEntry = timeEntry
    }
}

struct ModifyTimeEntryView_Previews: PreviewProvider {
    static var task: CDTask {
        let task = CDTask(context: PersistenceController.preview.container.viewContext)
        task.title = "The Task"
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
        ModifyTimeEntryView(timeEntry: timeEntry)
    }
}
