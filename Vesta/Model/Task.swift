//
//  TimeInterval.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-08-30.
//

import SwiftUI

struct Task: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String = ""
    var timeIntervals: [DateInterval] = []
}
