//
//  AddTaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var title: String
    
    var body: some View {
        List {
            TextField("Title", text: $title)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Add task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(title: .constant(""))
    }
}
