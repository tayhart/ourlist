//
//  ShoppingList.swift
//  OurList
//
//  Created by Taylor Hartman on 10/9/23.
//

import SwiftUI

struct ShoppingList: View {
    var body: some View {
        List(testData.items) { listItem in
            ListItemView(listItem: listItem)
        }
        .navigationTitle(testData.name)
    }
}


struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}
