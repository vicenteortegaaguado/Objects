//
//  ItemDetailView.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @State private var name: String = ""
    @State private var detail: String = ""
    @State private var type: String = ""
    
    let viewModel: ItemDetailViewModel
    
    var body: some View {
        List {
            Section {
                LabeledContent("Name:") {
                    TextField("", text: $name)
                }
                
                LabeledContent("Detail:") {
                    TextField("", text: $detail, axis: .vertical)
                }
                
                LabeledContent("Type:") {
                    TextField("", text: $type)
                }
            }
            
            Section {
                ForEach(viewModel.relationShips ?? []) { item in
                    ItemView(item: item)
                }
            } header: {
                Button("Relations") {
                    coordinator.present(sheet: .relationshipList(vm: viewModel.getRelationships()))
                }
            }
            
            Section {
                if viewModel.isReadyToSave(name: name, detail: detail, type: type) {
                    Button("Save", action: save)
                    Button("Reset", action: reset)
                }
            }
        }
        .navigationTitle("Detail")
        .onAppear(perform: reset)
    }
    
    private func save() {
        coordinator.request {
            try viewModel.save(name: name, detail: detail, type: type)
        }
    }
    
    private func reset() {
        name = viewModel.item?.name ?? ""
        detail = viewModel.item?.detail ?? ""
        type = viewModel.item?.type ?? ""
        viewModel.reset()
    }
}

// TODO: - Make a preview with mock data
//#Preview {
//    ItemDetailView()
//}
