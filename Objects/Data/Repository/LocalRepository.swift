//
//  LocalRepository.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation
import CoreData

protocol LocalRepositoryProtocol: AnyObject {
    var viewContext: NSManagedObjectContext { get }
    
    func fetchObjects<T: NSManagedObject>(withFetchRequest request: NSFetchRequest<T>) throws -> [T]?
    func saveContext() throws
}

/// Repository handling persistent store.
final class LocalRepository: LocalRepositoryProtocol {
    private var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Objects")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /**
     Current context
     */
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    /**
     Core Data Saving support
     */
    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
    /**
     Fetch the objects from persistent store
    - parameter request: setup
    - returns: Array with the objects
    */
    func fetchObjects<T: NSManagedObject>(withFetchRequest request: NSFetchRequest<T>) throws -> [T]? {
        let context = persistentContainer.viewContext
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}
