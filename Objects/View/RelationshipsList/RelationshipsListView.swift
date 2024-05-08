//
//  RelationshipsListView.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import SwiftUI

struct RelationshipsListView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var searchText: String = ""
    
    let viewModel: RelationshipsListViewModel
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.items ?? []) { item in
                    let isRelated: Bool = viewModel.selection.contains(item)
                    Button(action: {
                        isRelated
                        ? viewModel.remove(item)
                        : viewModel.add(item)
                    }, label: {
                        ItemView(item: item).foregroundStyle(Color.black)
                    })
                    .listRowBackground(isRelated ? Color.blue : Color.white)
                }
            } header: {
                Text("Items")
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText, { oldValue, newValue in viewModel.fetch(filter: newValue) })
        .navigationTitle("Relationships")
        .onAppear {
            viewModel.fetch()
        }
        .onDisappear {
            withAnimation {
                viewModel.updateSelection()
            }
        }
    }
}

// TODO: - Make a preview with mock data
//#Preview {
//    RelationshipsView()
//}
