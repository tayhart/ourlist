//
//  ListItem.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import Foundation

struct ListItem: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var notes: String
    var completed: Bool
}
