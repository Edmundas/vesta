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
                .modifier(ClearButton(text: $title))
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(title: .constant(""))
    }
}
