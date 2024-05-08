//
//  CoordinatorView.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import SwiftUI

struct CoordinatorView: View {
    
    @State private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.root
                .navigationDestination(for: Screen.self) { $0 }
                .sheet(item: $coordinator.sheet) { sheet in
                    NavigationStack {
                        sheet
                            .toolbar {
                                ToolbarItem {
                                    Button("Close", action: coordinator.dissmiss)
                                }
                            }
                    }
                }
        }
        .environment(coordinator)
    }
}

@Observable
final class Coordinator {
    
    fileprivate var path: [Screen] = []
    fileprivate var root: Screen
    fileprivate var sheet: Screen?
    
    init(root: Screen) {
        self.root = root
    }
    
    func link<Label: View>(to screen: Screen, label: () -> Label) -> some View {
        NavigationLink(value: screen, label: label)
    }
    
    func push(to screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func present(sheet: Screen) {
        self.sheet = sheet
    }
    
    func dissmiss() {
        sheet = nil
    }
}

enum Screen: Hashable, Identifiable, View {
    case itemList(vm: ItemListViewModel)
    case itemDetail(vm: ItemDetailViewModel)
    case relationshipList(vm: RelationshipsListViewModel)
    
    var body: some View {
        switch self {
        case .itemList(let vm):
            ItemListView(viewModel: vm)
        case .itemDetail(let vm):
            ItemDetailView(viewModel: vm)
        case .relationshipList(let vm):
            RelationshipsListView(viewModel: vm)
        }
    }
    
    var id: String {
        switch self {
        case .itemList: "itemList"
        case .itemDetail: "itemDetail"
        case .relationshipList: "relationshipList"
        }
    }
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// TODO: - Make a preview with mock data
//#Preview {
//    CoordinatorView(coordinator: .init(root: .itemList(vm: .init())))
//}
