//
//  User.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import Foundation

struct UserDTO: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
