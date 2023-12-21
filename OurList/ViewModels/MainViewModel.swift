//
//  File.swift
//  OurList
//
//  Created by Taylor Hartman on 10/17/23.
//

import FirebaseAuth
import Foundation

class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }

    public var isSignedIn: Bool {
        return User.shared.getCurrentUser() != nil
    }

    func userIsValid() -> Bool {
        guard let id = User.shared.userId else {
            return false
        }

        return !id.isEmpty
    }
}
