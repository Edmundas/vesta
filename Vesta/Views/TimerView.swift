//
//  TimerView.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-03.
//

import SwiftUI

struct TimerView: View {
    @Binding var tasks: [Task]
    
    var body: some View {
        Text("TIMER")
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(tasks: .constant(previewTasks))
    }
}
