//
//  ListViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import FirebaseFirestore
import Foundation
import FirebaseFirestoreSwift

class ListViewModel: ObservableObject {
    @Published var listName: String = ""
    @Published var showingNewItemView: Bool = false
    @Published var listId: String = ""
    @Published var items = [ListItem]()

    private let userId: String
    let db = Firestore.firestore()

    /// Delete todolist item
    /// - Parameter userId: user id of the logged in user
    /// - Parameter listId: list id of the list currently being shown
    init(userId: String) {
        self.userId = userId

        // Get the initial list id for the current user
        db.collection("users")
            .document("\(self.userId)")
            .getDocument { snapshot, error in
                guard let data = snapshot?.data(),
                      error == nil else {
                    return
                }
                self.listId = (data["listIds"] as? [String: String])?.first?.value.trimmingCharacters(in: .whitespaces) ?? ""
                self.fetchListData()
            }
    }

    func fetchListData() {
        guard !listId.isEmpty else {
            return
        }
    
        db.collection("lists")
            .document("\(listId)")
            .collection("listItems")
            .getDocuments { snapshot, error  in
                guard let snapshot, error == nil else {
                    return
                }

                DispatchQueue.main.async {
                    self.items = snapshot.documents.map {item in
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

    func deleteItem(_ id: String) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
