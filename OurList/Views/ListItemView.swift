//
//  ListItemView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

struct ListItemView: View {
    var listItem: ListItem
    var body: some View {
        HStack {
            CompletionButton(isSet: .constant(listItem.isDone))
            Text(listItem.name)
        }
    }
}

#Preview {
    ListItemView(listItem: ListItem(id: 10003, name: "Test", notes: "None", isDone: false))
}
