//
//  DataFormatter.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-06.
//

import SwiftUI

struct DataFormatter {
    static func formattedDuration(duration: Double) -> String {
        let s = Int(duration) % 60
        let m = Int(duration) / 60
        let h = Int(duration) / 3600
        
        return String(format:"%02d:%02d:%02d", h, m, s)
    }
}
