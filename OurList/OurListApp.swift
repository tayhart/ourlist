//
//  OurListApp.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

@available(iOS 17.0, *)
@main
struct OurListApp: App {
    @State private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
