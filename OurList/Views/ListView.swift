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
            EditListView(listModel: viewModel, editListPresented: $showEditListModal)
        }
    }

    @ViewBuilder
    func currentListView() -> some View {
        VStack {
            List(viewModel.items) { item in
                ListItemView(
                    listId: viewModel.listId,
                    listItem: item)
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
                viewModel.showingNewItemView = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $viewModel.showingNewItemView) {
            NewItemView(listId: viewModel.listId, newItemPresented: $viewModel.showingNewItemView)
        }
    }
}

#Preview {
    ListView(listId: "942DC81F-29B2-4AB8-B7AC-D8CCDCBAE307", color: "")
}
