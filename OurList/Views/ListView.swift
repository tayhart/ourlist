//
//  ShoppingList.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    @Environment(ModelData.self) var modelData
    @State private var filterByNotCompleted = false

    var filteredList: [ListItem] {
        modelData.testData.items.filter { item in
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
            .navigationTitle(modelData.testData.name)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ListView().environment(ModelData())
}
