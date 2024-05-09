//
//  ItemDetailViewModel.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation

@Observable
final class ItemDetailViewModel {
    
    // MARK: - Properties
    
    private let repository: ItemLocalRepositoryProtocol
    private(set) var item: Item?
    private(set) var relationShips: [Item]?
    private var oldRelationShips: [Item]?
    
    // MARK: - Init
    
    init(repository: ItemLocalRepositoryProtocol = ItemLocalRepository(), item: Item?) {
        self.repository = repository
        self.item = item
        let relationShips = repository.fetchRelationships(object: item)
        self.relationShips = relationShips
        self.oldRelationShips = relationShips
    }
}

extension ItemDetailViewModel {
    
    var isSelectionChanged: Bool {
        oldRelationShips != relationShips
    }
    
    func reset() {
        let relationShips = repository.fetchRelationships(object: item)
        self.relationShips = relationShips
        self.oldRelationShips = relationShips
    }
    
    /**
     Save data
    - parameter name: The name of the object
    - parameter detail: The detail of the object
    - parameter type: The type of the object
    - returns: None
    */
    func save(name: String, detail: String, type: String) {
        do {
            item = try repository.save(name: name, detail: detail, type: type, relationships: relationShips, currentObject: item)
        } catch {
            print("Error: \(error)")
        }
        reset()
    }
    
    /**
     Check changes
    - parameter name: The name of the object
    - parameter detail: The detail of the object
    - parameter type: The type of the object
    - returns: Flag to check if item has changed
    */
    func isReadyToSave(name: String, detail: String, type: String) -> Bool {
        guard !name.isEmpty, !detail.isEmpty, !type.isEmpty else { return false }
        return item?.name ?? "" != name || item?.detail ?? "" != detail || item?.type ?? "" != type || isSelectionChanged
    }
    
    /**
     Get relationships  viewModel to update them
    - parameter item: parent of relationships
    - returns: RelationshipsViewModel
    */
    func getRelationships() -> RelationshipsListViewModel {
        return RelationshipsListViewModel(repository: repository, selection: relationShips ?? []) { [weak self] selection in
            DispatchQueue.main.async {
                self?.relationShips = selection
            }
        }
    }
}
