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
            GridItem(.flexible())
        ]

    let height: CGFloat = 150

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Welcome back, \(viewModel.userName)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 16, leading: 8, bottom: 0, trailing: 8))

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.listCards) { card in
                        NavigationLink(destination: ListView(listId: card.id, color: card.color)) {
                            let color = Color(hex: card.color)
                            ListCardView(title: card.listTitle, color: color)
                                .frame(height: height)

                        }
                        .shadow(radius: 3.0)
                    }

                    ListCardView(title: "+")
                        .frame(height: height)
                        .onTapGesture {
                            showAddListModal.toggle()
                        }
                }
                .padding(.init(top: 0, leading: 8, bottom: 16, trailing: 8))
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
