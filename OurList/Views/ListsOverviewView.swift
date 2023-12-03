//
//  ListsOverviewView.swift
//  OurList
//
//  Created by Taylor Hartman on 12/3/23.
//

import SwiftUI

struct ListsOverviewView: View {
    @StateObject var viewModel: ListsOverviewViewModel

    var columns: [GridItem] = [
            GridItem(.flexible(minimum: 140)),
            GridItem(.flexible())
        ]

    let height: CGFloat = 150

    init(userId: String) {
        self._viewModel = StateObject(
            wrappedValue: ListsOverviewViewModel(userId: userId)
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.lists) { card in

                        NavigationLink(destination: ListView(listId: card.id)) {
                            ListCardView(title: card.listTitle)
                                .frame(height: height)
                        }
                    }
                }
                .padding()
                .navigationTitle("Your Lists")
            }
        }
    }
}

#Preview {
    ListsOverviewView(userId: .testUserId)
}
