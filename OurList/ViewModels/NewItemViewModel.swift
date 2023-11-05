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

    init() {}

    func save() {
        guard canSave else {
            return
        }

        // Get current user id
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        // Create Model
        let newId = UUID().uuidString
        let newItem = ListItem(
            id: newId,
            name: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            notes: "",
            isDone: false)

        // Save Model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
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
