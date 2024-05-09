//
//  RelationshipsViewModel.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation

@Observable
final class RelationshipsListViewModel {
    
    // MARK: - Properties
    
    private let repository: ItemLocalRepositoryProtocol
    private(set) var selection: [Item]
    private(set) var items: [Item]?
    private let update: ([Item]) -> Void
    
    // MARK: - Init
    
    init(repository: ItemLocalRepositoryProtocol = ItemLocalRepository(), selection: [Item], update: @escaping ([Item]) -> Void) {
        self.repository = repository
        self.selection = selection
        self.update = update
    }
}

extension RelationshipsListViewModel {
    
    func fetch(filter: String? = nil) throws {
        items = try repository.fetch(filter: filter)
    }
    
    func add(_ item: Item) {
        selection.append(item)
    }
    
    func remove(_ item: Item) {
        guard let index = selection.firstIndex(of: item) else { return }
        selection.remove(at: index)
    }
    
    func updateSelection() {
        update(selection)
    }
}
