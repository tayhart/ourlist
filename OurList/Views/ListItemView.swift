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

@available(iOS 17.0, *)
#Preview {
    ListItemView(listItem: ModelData().testData.items[0])
}
