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
            Image(systemName: listItem.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .foregroundColor(.black)
                .frame(width: 30, height: 30)
                .padding(.trailing, 10)

            Text(listItem.name)
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(listItem: ListItem(id: 111, name: "Chicken thigh", notes: "For favorite meal", completed: false))
    }
}
