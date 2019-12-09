//
//  Friend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tien Thuy Ho on 12/9/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var user: User?
    
    public var wrappedName: String {
        return name ?? "Unknown name"
    }
    
    public var wrappedId: String {
        return id ?? "Unknown id"
    }
}
