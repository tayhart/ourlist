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
    private let userId: String
    @Published var userName: String = ""
    @Published var lists: [ListCardModel] = []

    let db = Firestore.firestore()
    var listIds: [String] = []

    init(userId: String) {
        self.userId = userId

        db.collection("users")
            .document(userId)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data(),
                      error == nil,
                      let listIds = data["listIds"] as? [String: String]
                else {
                    return
                }

                self.lists = listIds.compactMap { listIdData in
                    return ListCardModel(
                        id: listIdData.value,
                        listTitle: listIdData.key)
                }
            }
    }
}
