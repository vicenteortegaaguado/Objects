//
//  Item+CoreDataProperties.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String
    @NSManaged public var detail: String
    @NSManaged public var type: String
    @NSManaged public var relationships: NSSet?

}

// MARK: Generated accessors for Relationships
extension Item {

    @objc(addRelationshipsObject:)
    @NSManaged public func addToRelationships(_ value: Item)

    @objc(removeRelationshipsObject:)
    @NSManaged public func removeFromRelationships(_ value: Item)

    @objc(addRelationships:)
    @NSManaged public func addToRelationships(_ values: NSSet)

    @objc(removeRelationships:)
    @NSManaged public func removeFromRelationships(_ values: NSSet)

}

extension Item : Identifiable {}
