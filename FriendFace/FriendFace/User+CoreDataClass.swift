//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Tien Thuy Ho on 12/8/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}

@objc(User)
public class User: NSManagedObject, Codable {
    
    enum CodingKeys: CodingKey {
        case id, name, age, company, email, address, about, friends
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        guard
            let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        friends = NSSet(array: try container.decode([Friend].self, forKey: .friends))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(Array(friends as! Set<Friend>), forKey: .friends)
    }
}
