//
//  ListsOverviewViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 12/3/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class  ListsOverviewViewModel: ObservableObject {
    let userId: String
    @Published var userName: String = ""
    @Published var listCards = [ListCardModel]()
    var listCardsTemp = [ListCardModel]()

    let db = Firestore.firestore()
    var listIds: [String: String] = [:]

    init(userId: String) {
        // TODO: Don't need to keep passing the userid around I guess
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
        self.userId = userId
        loadUsersLists()
    }

    private func loadUsersLists() {
        db.collection("users")
            .document(userId)
            .addSnapshotListener { snapshot, error in
                guard
                    let data = snapshot?.data(),
                    error == nil,
                    let dataLists = data["listIds"] as? [String: String]
                else {
                    return
                }

                self.listIds = dataLists
                self.createListModels()
            }
    }

    // TODO: Move these calls outside of the init? Is that bad form?
    private func createListModels() {
        // Need to get list data info
        listIds.forEach { id in
            let db = Firestore.firestore()
            db.collection("lists")
                .document(id.key)
                .getDocument { [weak self] snapshot, error in
                    guard let data = snapshot?.data(), error == nil, let self
                    else { return }

                    let title = data["name"] as? String ?? id.value
                    let listId = data["id"] as? String ?? id.key
                    let color = data["color"] as? String ?? ""
                    self.listCards.append(ListCardModel(
                        id: listId,
                        listTitle: title,
                        color: color))
                }
        }
    }
}
