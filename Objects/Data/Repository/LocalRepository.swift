//
//  LocalRepository.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//

import Foundation
import CoreData

protocol LocalRepositoryProtocol: AnyObject {
    static var persistentContainer: NSPersistentCloudKitContainer { get }
    
    func fetchObjects<T: NSManagedObject>(filter: String?, model: T.Type) -> [T]?
    func saveContext()
}

/// Repository handling persistent store.
final class LocalRepository: LocalRepositoryProtocol {
    static var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Objects")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /**
     Core Data Saving support
     */
    func saveContext() {
        let context = LocalRepository.persistentContainer.viewContext
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
    - parameter filter: Filter the objects by name.
    - returns: Array with the objects
    */
    func fetchObjects<T: NSManagedObject>(filter: String? = nil, model: T.Type) -> [T]? {
        let context = LocalRepository.persistentContainer.viewContext
        let request = NSFetchRequest<T>()
    
        if let filter = filter, !filter.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", filter)
        }
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            return try context.fetch(NSFetchRequest<T>(entityName: String(describing: T.self)))
        } catch let error {
            // TODO: - Manage Error
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
}
