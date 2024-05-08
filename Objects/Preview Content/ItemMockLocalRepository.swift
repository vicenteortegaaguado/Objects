//
//  ItemMockLocalRepository.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation


//
//
//final class ItemMockLocalRepository: ItemLocalRepositoryProtocol {
//    func fetch(filter: String?) -> [Item]? {
//        let json = """
//                    [
//                    {
//                        "name": "Object 1",
//                        "detail": "Detail of object 1",
//                        "type": "Type A"
//                    },
//                    {
//                        "name": "Object 2",
//                        "detail": "Detail of object 2",
//                        "type": "Type B"
//                    },
//                    {
//                        "name": "Object 3",
//                        "detail": "Detail of object 3",
//                        "type": "Type C"
//                    },
//                    {
//                        "name": "Object 4",
//                        "detail": "Detail of object 4",
//                        "type": "Type A"
//                    },
//                    {
//                        "name": "Object 5",
//                        "detail": "Detail of object 5",
//                        "type": "Type B"
//                    }
//                    ]
//                    """
//        do {
//            let objects = try JSONDecoder().decode([Item].self, from: json.data(using: .utf8)!)
//            return objects
//        } catch {
//            fatalError()
//        }
//    }
//    
//    func fetchRelationships(object: Item) -> [Item]? {
//        []
//    }
//    
//    func save(parent: Item, relationships: [Item]?) {
//        
//    }
//    
//    func save(name: String, detail: String, type: String, currentObject: Item?) {
//        
//    }
//    
//    func delete(object: Item) {
//        
//    }
//    
//    
//}
