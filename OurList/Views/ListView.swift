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
    @StateObject var viewModel: ListViewModel

    init(listId: String) {
        self._viewModel = StateObject(
            wrappedValue: ListViewModel(listId: listId)
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
        .navigationTitle(viewModel.listName)
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
    ListView(listId: "bPxUqd9lOlHQ6soMAs56")
}
