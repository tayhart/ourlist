//
//  List.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import Foundation

struct OurList: Hashable, Codable {
    var name: String
    var items: [ListItem]
}
