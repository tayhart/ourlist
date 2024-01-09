//
//  ModifyItemView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/25/23.
//

import SwiftUI

enum ModificationType {
    case add, edit, unknown
}

struct ModifyItemView: View {
    @StateObject var viewModel: ModifyItemViewModel
    @Binding var modifyItemPresented: Bool
    let modificationType: ModificationType

    init(
        listId: String,
        itemId: String?,
        modification: ModificationType,
        modifyItemPresented: Binding<Bool> = .constant(false)
    ) {
        self._viewModel = StateObject(
            wrappedValue: ModifyItemViewModel(listId: listId, itemId: itemId)
        )
        self._modifyItemPresented = modifyItemPresented
        self.modificationType = modification
    }

    var body: some View {
        VStack {
            let title: String  = {
                switch modificationType {
                    case .add:
                        "Add task"
                    case .edit:
                        "Edit task"
                    case .unknown:
                        "Error"
                }
            }()

            Text(title)
                .font(.title)
                .bold()

            VStack {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(.roundedBorder)

                // Due Date
                DatePicker("Due date", selection: $viewModel.dueDate, displayedComponents: .date)
                    .datePickerStyle(.compact)

                // Notes
                TextField("Add notes", text: $viewModel.notes, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(5...10)

            }.padding()

            // button
            OLButton(title: "Save task", background: .purple) {
                if viewModel.canSave {
                    viewModel.save(modType: modificationType)
                    modifyItemPresented = false
                } else {
                    viewModel.showAlert = true
                }
            }
            .frame(maxHeight: 42)
            .padding()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Please fill in all fields and select a viable due date."))
        }
    }
}

#Preview {
    ModifyItemView(
        listId:"1BEB02E6-48C0-48C2-B846-1DBD621171C4 ",
        itemId: "893D7C96-B8F7-42C4-BFDE-224A7CD0D191",
        modification: .edit,
        modifyItemPresented: Binding(get: {
        return true
    }, set: { _ in
    }))
}
