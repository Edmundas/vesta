//
//  TaskView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    
    var body: some View {
        Text(task.title)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: Task.data[0])
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
