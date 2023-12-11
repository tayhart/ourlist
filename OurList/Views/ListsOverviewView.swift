//
//  ListsOverviewView.swift
//  OurList
//
//  Created by Taylor Hartman on 12/3/23.
//

import SwiftUI

struct ListsOverviewView: View {
    @StateObject var viewModel = ListsOverviewViewModel()
    @State private var showAddListModal = false

    var columns: [GridItem] = [
            GridItem(.flexible(minimum: 140)),
            GridItem(.flexible())
        ]

    let height: CGFloat = 150

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.listCards) { card in
                        NavigationLink(destination: ListView(listId: card.id)) {
                            let color = Color(uiColor: UIColor(hex: card.color) ?? .cyan)
                            ListCardView(title: card.listTitle, color: color)
                                .frame(height: height)
                        }
                    }

                    ListCardView(title: "+")
                        .frame(height: height)
                        .onTapGesture {
                            showAddListModal.toggle()
                        }
                }
                .padding()
                .navigationTitle("Welcome back, \(viewModel.userName)")
            }
        }
        .sheet(isPresented: $showAddListModal) {
            NewListView(
                userId: viewModel.userId,
                userLists: viewModel.listIds,
                newListPresented: $showAddListModal)
        }
    }
}

#Preview {
    ListsOverviewView()
}
