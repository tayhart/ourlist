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
                self.createListModels() { cardsStorage in
                    DispatchQueue.main.async {
                        self.listCards = cardsStorage
                    }
                }
            }
    }

    // TODO: Move these calls outside of the init? Is that bad form?
    private func createListModels(_ completion: @escaping ([ListCardModel]) -> Void) {
        var tracker = 0
        var listCardsTemp = [ListCardModel]()
        let listCount = listIds.count
        // Need to get list data info
        listIds.forEach { id in
            let db = Firestore.firestore()
            db.collection("lists")
                .document(id.key)
                .getDocument { snapshot, error in
                    guard let data = snapshot?.data(), error == nil
                    else { return }

                    let title = data["name"] as? String ?? id.value
                    let listId = data["id"] as? String ?? id.key
                    let color = data["color"] as? String ?? ""
                    listCardsTemp.append(ListCardModel(
                        id: listId,
                        listTitle: title,
                        color: color))

                    if tracker == listCount - 1 {
                        completion(listCardsTemp)
                    }

                    tracker += 1
                }
        }
    }
}
