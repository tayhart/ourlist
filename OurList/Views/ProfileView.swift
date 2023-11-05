//
//  ProfileView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/16/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack {

            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
