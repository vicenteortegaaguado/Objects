//
//  LocalItemRepository.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation

protocol ItemLocalRepositoryProtocol: AnyObject {
    func fetch(filter: String?) -> [Item]?
    func fetchRelationships(object: Item) -> [Item]?
    func save(name: String, detail: String, type: String, relationships: [Item]?, currentObject: Item?) -> Item
    func delete(object: Item)
}

final class ItemLocalRepository: ItemLocalRepositoryProtocol {
    
    private let localRepository: LocalRepositoryProtocol
    
    init(localRepository: LocalRepositoryProtocol = LocalRepository()) {
        self.localRepository = localRepository
    }
    /**
     Fetch the objects from persistent store
    - parameter filter: Filter the objects by name.
    - returns: Array with the objects
    */
    func fetch(filter: String? = nil) -> [Item]? {
        let request = Item.fetchRequest()
        // TODO: - Extract the logic to be able to setup from function parametes
        if let filter = filter, !filter.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", filter)
        }
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return localRepository.fetchObjects(withFetchRequest: request)
    }
    /**
     Fetch the relation from an object
    - parameter object: Parent object.
    - returns: Array with objects that has the relationships with the object
    */
    @MainActor func fetchRelationships(object: Item) -> [Item]? {
        guard let objects = object.relationships?.allObjects,
              let relationships = objects as? [Item] else {
            return nil
        }
        return relationships
    }
    /**
     Fetch the relation from an object
    - parameter object: Parent object.
    - returns: Array with objects that has the relationships with the object
    */
    @MainActor func save(name: String, detail: String, type: String, relationships: [Item]?, currentObject: Item?) -> Item {
        let item: Item
        
        if let currentObject = currentObject {
            item = currentObject
        } else {
            let context = localRepository.viewContext
            item = Item(context: context)
        }
        
        item.name = name
        item.detail = detail
        item.type = type
        
        if let relationships {
            item.relationships = nil
            relationships.forEach { relationship in
                item.addToRelationships(relationship)
            }
        }
        localRepository.saveContext()
        return item
    }
    /**
     Delete the object from persistent store.
    - parameter object: Object to delete
    - returns: None
    */
    @MainActor func delete(object: Item) {
        localRepository.viewContext.delete(object)
        localRepository.saveContext()
    }
}
