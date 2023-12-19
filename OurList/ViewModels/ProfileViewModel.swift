//
//  ProfileViewModel.swift
//  OurList
//
//  Created by Taylor Hartman on 10/24/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//TODO: Update to use the user singleton
class ProfileViewModel: ObservableObject {
    @Published var user: UserDTO? = nil

    init() {}

    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil, let self else {
                    return
                }

                DispatchQueue.main.async {
                    self.user = UserDTO(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0)
                }
            }
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
