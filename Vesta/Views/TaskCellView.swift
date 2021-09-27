//
//  TaskCellView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TaskCellView: View {
    @Environment(\.editMode) var editMode
    
    @ObservedObject var task: CDTask
    
    @StateObject private var viewModel = TaskCellViewModel()
    @State private var showingEditTaskSheet = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .padding(.bottom, 2.0)
                
                Text(DataFormatter.formattedDuration(duration: viewModel.duration))
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
                    if viewModel.taskRunning {
                        viewModel.stopTask()
                    } else {
                        viewModel.startTask()
                    }
                }, label: {
                    Image(systemName: viewModel.taskRunning ? "stop.circle.fill" : "play.circle.fill")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 44.0, height: 44.0)
                        .foregroundColor(viewModel.taskRunning ? .red : .accentColor)
                })
            }
        }
        .padding(.vertical)
        .onAppear(perform: prepareViewModel)
        .sheet(isPresented: $showingEditTaskSheet) {
            NavigationView {
                ModifyTaskView(task: task)
            }
        }
    }
}

extension TaskCellView {
    private func prepareViewModel() {
        viewModel.task = task
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
        TaskCellView(task: task)
            .previewLayout(.sizeThatFits)
    }
}
