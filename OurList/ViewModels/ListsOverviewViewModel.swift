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
    @Published var lists: [ListCardModel] = []

    let db = Firestore.firestore()
    var listIds: [String: String] = [:]

    init(userId: String) {
        self.userId = userId
        reloadLists()
    }

    func reloadLists() {
        db.collection("users")
            .document(userId)
            .addSnapshotListener { snapshot, error in
                guard let data = snapshot?.data(),
                      error == nil,
                      let dataLists = data["listIds"] as? [String: String]
                else {
                    return
                }

                self.listIds = dataLists

                DispatchQueue.main.async {
                    self.lists = self.listIds.compactMap { listIdData in
                        return ListCardModel(
                            id: listIdData.key,
                            listTitle: listIdData.value)
                    }
                }
            }
    }
}
