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
    var onDelete: () -> Void

    init(
        listModel: ListViewModel,
        onDeletion: (@escaping () -> Void),
        editListPresented: Binding<Bool> = .constant(false)
    ) {
        self._viewModel = StateObject(wrappedValue: EditListViewModel(
            listId: listModel.listId,
            originalTitle: listModel.listName,
            originalColorHex: listModel.colorHex))
        self._editListPresented = editListPresented
        self.onDelete = onDeletion
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

                OLButton(title: "Save", background: .green) {
                    if viewModel.canSave {
                        viewModel.save()
                        editListPresented = false
                    } else {
                        // show alert
                    }
                }

                OLButton(title: "Delete this list", background: .red) {
                    // TODO: prompt if they are sure
                    onDelete()
                }
            }
        }
    }
}

#Preview {
    EditListView(listModel: ListViewModel(listId: "", color: ""), onDeletion: {})
}
