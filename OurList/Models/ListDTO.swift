//
//  List.swift
//  OurList
//
//  Created by Taylor Hartman on 12/4/23.
//

import Foundation

struct ListDTO: Hashable, Codable, Identifiable {
    let id: String
    var name: String
    var color: String
    var userIds: [String]
}
