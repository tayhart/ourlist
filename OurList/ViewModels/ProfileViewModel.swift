//
//  ProfileViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/24/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    init() {}

    // TODO: This makes no sense to live in this viewmodel - move to where it makes sense
    func toggleIsDone(item: ListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
