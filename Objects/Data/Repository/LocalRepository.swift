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
    
    func fetchObjects<T: NSManagedObject>(withFetchRequest request: NSFetchRequest<T>) -> [T]?
    func saveContext()
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
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO: - Manage Error
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
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
        } catch let error {
            
        }
    }
}
