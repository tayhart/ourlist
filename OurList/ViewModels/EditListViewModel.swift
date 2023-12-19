//
//  EditListViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 12/15/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class EditListViewModel: ObservableObject {
    @Published var title: String
    @Published var color: Color
    var listId: String

    var userId: String

    var canSave: Bool {
        guard
            !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return false
        }

        return true
    }

    init(
        listId: String,
        originalTitle: String,
        originalColorHex: String
    ) {
        self.listId = listId
        title = originalTitle
        color = Color(hex: originalColorHex)
        userId = User.shared.userId ?? ""
    }

    func save() {
        guard canSave else { return }

        // Create model
        let hexColor: String = color.toHex() ?? "#FFFFFF"
        let updatedList = ListDTO(
            id: listId,
            name: title, 
            color: hexColor,
            userIds: [userId]) //TODO: pass in userIDs to track here

        let db = Firestore.firestore()
        db.collection("lists")
            .document(listId)
            .setData(updatedList.asDictionary())

        // Update user's list access with the correct name
        guard let userLists = User.shared.listIds else {
            return
        }
        
        var userListsCopy = userLists
        userListsCopy[listId] = title

        let userDocument = db.collection("users")
            .document(userId)
        userDocument.updateData(["listIds" : userListsCopy])

        // TODO: need to indicate to the overview view model that it needs to refresh...
        // maybe can add something to the user like a refresh token that we update or change
        // every time we update their lists so it'll kick off the refresh? Like just have a
        // refresh token int that we count up and it will trigger that the User changed a
        // value in a list they are associated with so we should update it.
        // OR we should create a snapshot listener for each list in the overview viewmodel
    }
}
