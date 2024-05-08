//
//  Item+CoreDataClass.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 8/5/24.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject, Codable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            name = try values.decode(String.self, forKey: .name)
            detail = try values.decode(String.self, forKey: .detail)
            type = try values.decode(String.self, forKey: .type)
        } catch {
            print ("error")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(name, forKey: .name)
            try container.encode(detail, forKey: .detail)
            try container.encode(type, forKey: .type)
        } catch {
            print("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case detail
        case type
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
