//
//  TaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TaskCellView: View {
    let task: Task
    
    var body: some View {
        Text(task.title)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(task: previewTasks[0])
            .previewLayout(.fixed(width: 400, height: 60))
    }
}