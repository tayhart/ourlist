//
//  ListItem.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import Foundation
import SwiftUI

struct ListItem: Hashable, Codable, Identifiable {
    let id: String
    var name: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var notes: String
    var isDone: Bool

    var dueDateColor: Color {
        let today = Date()
        let due = Date(timeIntervalSince1970: dueDate)

        if today < due {
            return .green
        } else if due == today {
            return .orange
        } else {
            return .red
        }
    }

    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
