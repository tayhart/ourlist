//
//  ListItem.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import Foundation

struct ListItem: Hashable, Codable, Identifiable {
    let id: String
    var name: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var notes: String
    var isDone: Bool

    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
