//
//  NewItemViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/25/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false

    var listId: String = ""

    init(listId: String) {
        self.listId = listId
    }

    func save() {
        guard canSave else {
            return
        }

        // Create Model
        let newId = UUID().uuidString
        let newItem = ListItem(
            id: newId,
            name: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            listId: listId)

        // Save Model
        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .collection("listItems")
            .document(newId)
            .setData(newItem.asDictionary())
    }

    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }

        return true
    }
}
