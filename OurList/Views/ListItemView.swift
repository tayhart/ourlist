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
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(listItem.name)
                        .font(.body)
                        .bold()
                    Text("\(Date(timeIntervalSince1970: listItem.dueDate).formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                .padding()
                Spacer()

                Button {
                    // add step of claiming before toggling if the item is done
                    viewModel.toggleIsDone(item: listItem)
                } label: {
                    let name = listItem.isDone ? "checkmark.circle.fill" : "circle"
                    let color: Color = listItem.isDone ? .green : .black
                    Image(systemName: name)
                        .foregroundColor(color)
                }
                .padding()
                .buttonStyle(.plain)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.white)
                .shadow(radius: 2)
        )
        .padding(.init(
            top: 2.0,
            leading: 4.0,
            bottom: 2.0,
            trailing: 4.0))
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
