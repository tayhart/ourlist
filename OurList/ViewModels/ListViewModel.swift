//
//  ListViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import FirebaseFirestore
import Foundation

class ListViewModel: ObservableObject {
    @Published var listName: String = ""
    @Published var showingNewItemView: Bool = false

    private let userId: String
    
    /// Delete todolist item
    /// - Parameter userId: user id of the logged in user
    init(userId: String) {
        self.userId = userId
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
