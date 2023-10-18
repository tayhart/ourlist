//
//  ContentView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            ListView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
