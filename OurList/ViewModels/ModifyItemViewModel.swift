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
    let itemIdentifier: String?

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
                // this isn't working quite right - keeps just replacing w/ fallback
                let time = ["dueDate"] as? TimeInterval ?? Date().timeIntervalSince1970
                self.dueDate = Date(timeIntervalSince1970: time)
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
                // we don't want to overwrite the uuid so will have to write
                // a modify method or at least adjust how we use the item id
                return
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

    }

    var canSave: Bool {
        guard 
            !title.trimmingCharacters(in: .whitespaces).isEmpty,
            dueDate >= Date().addingTimeInterval(-86400)
        else {
            return false
        }

        return true
    }
}
