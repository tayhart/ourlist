//
//  ListViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var listItems: [ListItem]
    @Published var listName: String = ""

    init() {
        // Temporary test data
        listItems = [
            ListItem(id: 1, name: "VOU 787", notes: "", isDone: false),
            ListItem(id: 2, name: "FINA", notes: "", isDone: false),
            ListItem(id: 3, name: "NADIE SABE", notes: "", isDone: true),
            ListItem(id: 4, name: "MR OCTOBER", notes: "", isDone: false),
            ListItem(id: 5, name: "CYBERTRUCK", notes: "", isDone: true),
            ListItem(id: 6, name: "PERRO NEGRO", notes: "", isDone: false)
        ]

        listName = "Test"
    }
}
