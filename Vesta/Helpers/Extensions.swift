//
//  Extensions.swift
//  Vesta
//
//  Created by Edmundas Matusevicius on 2021-09-07.
//

import SwiftUI

extension RandomAccessCollection where Element : Comparable {
    func insertionReverseIndex(of value: Element) -> Index {
        var slice : SubSequence = self[...]

        while !slice.isEmpty {
            let middle = slice.index(slice.startIndex, offsetBy: slice.count / 2)
            if value > slice[middle] {
                slice = slice[..<middle]
            } else {
                slice = slice[index(after: middle)...]
            }
        }
        return slice.startIndex
    }
}
