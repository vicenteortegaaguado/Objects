//
//  ItemListViewModel.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation

@Observable
final class ItemListViewModel {
    
    // MARK: - Properties
    
    private let repository: ItemLocalRepositoryProtocol
    private(set) var items: [Item]?
    
    // MARK: - Init
    
    init(repository: ItemLocalRepositoryProtocol = ItemLocalRepository()) {
        self.repository = repository
    }
}

extension ItemListViewModel {
    
    /**
     Fetch all the objects
    - parameter filter: Filter the objects by name.
    - returns: None
    */
    func fetch(filter: String? = nil) {
        do {
            items = try repository.fetch(filter: filter)
        } catch {
            print("Error: \(error)")
        }
    }
    
    /**
     Delete object by IndexSet
    - parameter indexSet: IndexSet for finding and deleting object
    - returns: None
     */
    func delete(with indexSet: IndexSet) {
        for index in indexSet {
            if let item = items?[index] {
                do {
                    try repository.delete(object: item)
                    items?.remove(at: index)
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    /**
     Get detail  viewModel to add or update Item
    - parameter item: selected value
    - returns: ItemDetailViewModel
    */
    func getDetail(item: Item?) -> ItemDetailViewModel {
        .init(repository: repository, item: item)
    }
}
