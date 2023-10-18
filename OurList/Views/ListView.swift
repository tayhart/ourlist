//
//  ShoppingList.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    @State private var filterByNotCompleted = false

    var filteredList: [ListItem] {
        viewModel.listItems.filter { item in
            (!filterByNotCompleted || !item.isDone)
        }
    }

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $filterByNotCompleted) {
                    Text("Show only not completed")
                }

                ForEach(filteredList) { listItem in
                    ListItemView(listItem: listItem)
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Test")
        }
    }
}

#Preview {
    ListView()
}
