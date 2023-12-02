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

    private let userId: String

    init(userId: String) {
        self.userId = userId

        self._viewModel = StateObject(
            wrappedValue: ListViewModel(userId: userId)
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
    ListView(userId: "2iZsrS0iVsQLWidEX6W8QNoexp13")
}
