//
//  ListViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import FirebaseFirestore
import Foundation
import FirebaseFirestoreSwift
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var listName: String = ""
    @Published var showingNewItemView: Bool = false
    @Published var listId: String
    var colorHex: String
    @Published var items = [ListItem]()

    let db = Firestore.firestore()

    /// Delete todolist item
    /// - Parameter userId: user id of the logged in user
    /// - Parameter listId: list id of the list currently being shown
    init(listId: String, color: String) {
        self.listId = listId
        self.colorHex = color
        fetchListData()
    }

    func fetchListData() {
        guard !listId.isEmpty else {
            return
        }

        // Get the list name
        db.collection("lists")
            .document(listId)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self,
                      let data = snapshot?.data(),
                      error == nil
                else {
                    return
                }
                
                self.listName = data["name"] as? String ?? ""
            }

        // Setup listener for items in the DB
        db.collection("lists")
            .document(listId)
            .collection("listItems")
            .addSnapshotListener { snapshot, error in
                guard let itemDocs = snapshot?.documents, error == nil else {
                    return
                }

                DispatchQueue.main.async {
                    self.items = itemDocs.map {item in
                        ListItem(
                            id: item["id"] as? String ?? "",
                            name: item["name"] as? String ?? "",
                            dueDate: item["dueDate"] as? TimeInterval ?? Date().timeIntervalSince1970,
                            createdDate: item["createdDate"] as? TimeInterval ?? Date().timeIntervalSince1970,
                            isDone: item["isDone"] as! Bool)
                    }
                }
            }
    }

    func addItem(_ item: ListItem) {
        
    }

    // TODO: add retry functionality
    // also add a completion closure so that we can tell if the operation succeeded or
    // not
    func deleteList() {
        guard let uid = User.shared.getCurrentUser(),
              var userListIds = User.shared.listIds else {
            return
        }

        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .delete()

        userListIds.removeValue(forKey: listId)

        db.collection("users")
            .document(uid)
            .updateData(["listIds": userListIds])
    }

    func deleteItem(_ id: String) {
        let db = Firestore.firestore()

        db.collection("lists")
            .document(listId)
            .collection("listItems")
            .document(id)
            .delete()
    }
}
