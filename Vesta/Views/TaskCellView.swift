//
//  TaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TaskCellView: View {
    @State var task: Task
    
    var body: some View {
        Text(task.title ?? "")
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        // TODO: set up preview data
        TaskCellView(task: Task())
            .previewLayout(.sizeThatFits)
    }
}
