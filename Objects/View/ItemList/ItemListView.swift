//
//  ItemListView.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import SwiftUI

struct ItemListView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var searchText: String = ""
    
    let viewModel: ItemListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items ?? []) { item in
                coordinator.link(to: .itemDetail(vm: viewModel.getDetail(item: item))) {
                    ItemView(item: item)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .onAppear { viewModel.fetch() }
        .searchable(text: $searchText)
        .onChange(of: searchText, { oldValue, newValue in viewModel.fetch(filter: newValue) })
        .navigationTitle("List")
        .navigationDestination(for: Item.self) { item in
            ItemDetailView(viewModel: viewModel.getDetail(item: item))
        }
        .toolbar {
            ToolbarItem {
                Button("Add item") {
                    coordinator.push(to: .itemDetail(vm: viewModel.getDetail(item: nil)))
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.delete(with: offsets)
        }
    }
}

// TODO: - Make a preview with mock data
//#Preview {
//    ItemListView(viewModel: .init(repository: ItemMockLocalRepository()))
//}
