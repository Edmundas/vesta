//
//  ModifyTaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct ModifyTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = ModifyTaskViewModel()
    
    var task: CDTask?
    
    var body: some View {
        List {
            TextField("Title", text: $viewModel.title)
                .modifier(ClearButton(text: $viewModel.title))
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Task")
        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: Button("Save") {
                viewModel.save()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(viewModel.title.isEmpty)
        )
        .onAppear(perform: prepareViewModel)
    }
}

extension ModifyTaskView {
    private func prepareViewModel() {
        if task != nil {
            viewModel.task = task!
            viewModel.title = task!.title
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyTaskView()
    }
}
