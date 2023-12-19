//
//  NewListViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 12/4/23.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class NewListViewModel: ObservableObject {
    @Published var title = ""
    @Published var color: Color = .init(red: 0, green: 0, blue: 0)

    var userId: String
    var userLists: [String: String]

    var canSave: Bool {
        guard 
            !title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }

        return true
    }

    init(userId: String, userLists: [String: String]) {
        self.userId = userId
        self.userLists = userLists
    }

    func save() {
        guard canSave else { return }

        // Create model
        let hexColor: String = color.toHex() ?? "#FFFFFF"
        let listId = UUID().uuidString
        let newList = ListDTO(
            id: listId,
            name: title,
            color: hexColor,
            userIds: [userId])

        // Save model to lists collection
        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .setData(newList.asDictionary())

        // Link the list id to the current user
        let userDocument = db.collection("users")
            .document(userId)
        userLists[listId] = newList.name
        userDocument.updateData(["listIds" : userLists])
    }
}
