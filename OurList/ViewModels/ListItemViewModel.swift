//
//  ListItemViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 11/5/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ListItemViewModel: ObservableObject {

    init() {}

    func toggleIsDone(item: ListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("lists")
            .document(itemCopy.listId)
            .collection("listItems")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
