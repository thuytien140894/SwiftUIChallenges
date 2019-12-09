//
//  Friend+CoreDataClass.swift
//  FriendFace
//
//  Created by Tien Thuy Ho on 12/8/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case id, name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        guard
            let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext) else {
            fatalError("Failed to decode Friend")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
