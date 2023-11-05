//
//  ShoppingList.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ListView: View {
    @StateObject var viewModel: ListViewModel
    @FirestoreQuery var items: [ListItem]

    private let userId: String

    init(userId: String) {
        self.userId = userId
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")

        self._viewModel = StateObject(
            wrappedValue: ListViewModel(userId: userId)
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ListItemView(listItem: item)
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
            .navigationTitle("List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

#Preview {
    ListView(userId: "2iZsrS0iVsQLWidEX6W8QNoexp13")
}
