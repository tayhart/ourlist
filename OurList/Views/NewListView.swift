//
//  NewListView.swift
//  OurList
//
//  Created by Taylor Hartman on 12/4/23.
//

import SwiftUI

struct NewListView: View {
    @StateObject var viewModel: NewListViewModel
    @Binding var newListPresented: Bool
    var userId: String = ""

    init(
        userId: String,
        userLists: [String: String],
        newListPresented: Binding<Bool> = .constant(false)
    ) {
        self._viewModel = StateObject(
            wrappedValue: NewListViewModel(userId: userId, userLists: userLists)
        )
        self._newListPresented = newListPresented
    }

    var body: some View {
        VStack {
            Text("New list")
                .font(.title)
                .bold()
                .padding()

            Form {
                // Title
                TextField("Name", text: $viewModel.title)
                    .textFieldStyle(.automatic)

                ColorPicker("Color", selection: $viewModel.color, supportsOpacity: false)

                OLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        newListPresented = false
                    } else {
                        // show alert
                    }
                }
            }
        }
    }

}

#Preview {
    NewListView(userId: .testUserId, userLists: [:])
}
