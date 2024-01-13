//
//  NewItemViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/25/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ModifyItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var notes = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    var createdDate: TimeInterval?
    let itemIdentifier: String?
    var isDone: Bool?

    var listId: String = ""

    init(listId: String, itemId: String?) {
        self.listId = listId

        guard let itemId else {
            self.itemIdentifier = nil
            return
        }
        self.itemIdentifier = itemId
        // set all the values
        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .collection("listItems")
            .document(itemId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil, let self else {
                    return
                }
                let time = data["dueDate"] as? TimeInterval ?? Date().timeIntervalSince1970
                self.dueDate = Date(timeIntervalSince1970: time)
                self.createdDate = data["createdDate"] as? TimeInterval
                self.isDone = data["isDone"] as? Bool ?? false
                self.notes = data["notes"] as? String ?? ""
                self.title = data["name"] as? String ?? ""
            }
    }

    func save(modType: ModificationType) {
        guard canSave else {
            return
        }

        switch modType {
            case .add:
                saveNewItem()
            case .edit:
                modifyExistingItem()
            case .unknown:
                return
        }
    }

    private func saveNewItem() {
        // Create Model
        let newId = UUID().uuidString
        let newItem = ListItem(
            id: newId,
            name: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            notes: notes,
            isDone: false)

        // Save Model
        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .collection("listItems")
            .document(newId)
            .setData(newItem.asDictionary())
    }

    private func modifyExistingItem() {
        guard let itemIdentifier else {
            // error toast?
            return
        }
        let modifiedItem = ListItem(
            id: itemIdentifier,
            name: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: createdDate ?? Date().timeIntervalSince1970,
            notes: notes,
            isDone: isDone ?? false)

        // Save Model
        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .collection("listItems")
            .document(itemIdentifier)
            .setData(modifiedItem.asDictionary())
    }

    var canSave: Bool {
        guard 
            !title.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }

        return true
    }
}
