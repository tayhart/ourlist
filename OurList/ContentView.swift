//
//  ContentView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            if #available(iOS 17.0, *) {
                ListView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ContentView().environment(ModelData())
    } else {
        ContentView()
    }
}
