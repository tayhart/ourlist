//
//  NewItemView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/25/23.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel: NewItemViewModel
    @Binding var newItemPresented: Bool

    init(listId: String, newItemPresented: Binding<Bool> = .constant(false)) {
        self._viewModel = StateObject(
            wrappedValue: NewItemViewModel(listId: listId)
        )
        self._newItemPresented = newItemPresented
    }

    var body: some View {
        VStack {
            Text("New item")
                .font(.system(size: 32))
                .bold()
                .padding()

            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(.automatic)
                // Due Date
                DatePicker("Due date", selection: $viewModel.dueDate)
                    .datePickerStyle(.graphical)

                // button
                OLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields and select a viable due date."))
            }
        }
    }
}

#Preview {
    NewItemView(listId:"bPxUqd9lOlHQ6soMAs56", newItemPresented: Binding(get: {
        return true
    }, set: { _ in
    }))
}
