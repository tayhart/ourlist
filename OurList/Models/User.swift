//
//  User.swift
//  OurList
//
//  Created by Taylor Hartman on 12/18/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class User {
    static let shared = User()

    private(set) var userId: String? = nil {
        didSet {
            Task {
                refreshUserData()
            }
        }
    }
    private(set) var name: String?
    private(set) var email: String?
    private(set) var joined: TimeInterval?
    private(set) var listIds: [String: String]?

    /// Should rarely be called
    func getCurrentUser() {
        userId = Auth.auth().currentUser?.uid
    }

    private func refreshUserData() {
        guard let userId,
              !userId.isEmpty
        else {
            resetUserData()
            return
        }

        // Set up snapshot listener for user's data
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self,
                      let data = snapshot?.data(),
                      error == nil
                else {
                    self?.resetUserData()
                    return
                }

                self.name = data["name"] as? String
                self.email = data["email"] as? String
                self.joined = data["joined"] as? TimeInterval
                self.listIds = data["listIds"] as? [String: String]
            }
    }

    private func resetUserData() {
        name = nil
        email = nil
        joined = nil
        listIds = nil
    }
}
