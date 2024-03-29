//
//  ShoppingList.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct ListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ListViewModel
    @State private var showEditListModal = false

    init(listId: String, color: String) {
        self._viewModel = StateObject(
            wrappedValue: ListViewModel(listId: listId, color: color)
        )
    }

    var body: some View {
        NavigationView {
            if viewModel.listId.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                currentListView()
            }
        }
        .navigationTitle($viewModel.listName)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "chevron.backward")
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showEditListModal.toggle()
                } label: {
                    Label("Edit list", systemImage: "slider.horizontal.3")
                }
            }
        }
        .sheet(isPresented: $showEditListModal) {
                EditListView(
                    listModel: viewModel,
                    onDeletion: {
                        // add closure and only dismiss on success, otherwise add toast
                        // to notify user that operation was not successful
                        viewModel.deleteList()
                        dismiss()
                        showEditListModal.toggle()
                    },
                    editListPresented: $showEditListModal)
                .presentationDetents([.medium])
        }
    }

    @ViewBuilder
    func currentListView() -> some View {
        VStack {
            List(viewModel.items) { item in
                ListItemView(
                    listId: viewModel.listId,
                    listItem: item)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    viewModel.modificationType = .edit
                    viewModel.itemId = item.id
                }
                .swipeActions {
                    Button {
                        //Delete
                        viewModel.deleteItem(item.id)
                    } label: {
                        Text("Delete")
                    }
                    .tint(.red)
                }
            }
            .listStyle(.plain)
        }
        .toolbar {
            Button {
                viewModel.modificationType = .add
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $viewModel.showingModifyItemView) {
            ModifyItemView(
                listId: viewModel.listId,
                itemId: viewModel.itemId,
                modification: viewModel.modificationType,
                modifyItemPresented: $viewModel.showingModifyItemView)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    ListView(listId: "845395D7-94A9-41CA-B328-DA7916763279", color: "")
}
