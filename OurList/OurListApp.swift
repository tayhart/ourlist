//
//  OurListApp.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import FirebaseCore
import SwiftUI

@main
struct OurListApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
