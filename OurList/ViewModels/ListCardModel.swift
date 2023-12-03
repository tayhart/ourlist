//
//  ListCardModel.swift
//  OurList
//
//  Created by Taylor Hartman on 12/3/23.
//

import Foundation
import FirebaseFirestore

struct ListCardModel: Identifiable {
    let id: String
    let listTitle: String
}
