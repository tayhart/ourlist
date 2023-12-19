//
//  EditListView.swift
//  OurList
//
//  Created by Taylor Hartman on 12/15/23.
//

import SwiftUI

struct EditListView: View {
    @StateObject var viewModel: EditListViewModel
    @Binding  var editListPresented: Bool

    init(
        listModel: ListViewModel,
        editListPresented: Binding<Bool> = .constant(false)
    ) {
        self._viewModel = StateObject(wrappedValue: EditListViewModel(
            listId: listModel.listId,
            originalTitle: listModel.listName,
            originalColorHex: listModel.colorHex))
        self._editListPresented = editListPresented
    }

    var body: some View {
        VStack {
            Text("Edit list")
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
                        editListPresented = false
                    } else {
                        // show alert
                    }
                }
            }
        }
    }
}

#Preview {
    EditListView(listModel: ListViewModel(listId: "", color: ""))
}
