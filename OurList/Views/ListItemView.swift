//
//  ListItemView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

struct ListItemView: View {
    @StateObject var viewModel: ListItemViewModel
    var listItem: ListItem

    init(listId: String, listItem: ListItem) {
        self.listItem = listItem
        self._viewModel = StateObject(
            wrappedValue: ListItemViewModel(listId: listId)
        )
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(listItem.name)
                    .font(.body)
                    .bold()
                Text("\(Date(timeIntervalSince1970: listItem.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            Spacer()

            Button {
                viewModel.toggleIsDone(item: listItem)
            } label: {
                Image(systemName: listItem.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    ListItemView(
        listId: "",
        listItem: ListItem(
            id: "123",
            name: "Test",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: true))
}
