//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tien Thuy Ho on 12/9/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var about: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var friends: NSSet?

    public var wrappedId: String {
        return id ?? "Unknown id"
    }
    
    public var wrappedName: String {
        return name ?? "Unknown name"
    }
    
    public var wrappedAbout: String {
        return about ?? "Unknown about"
    }
    
    public var wrappedCompany: String {
        return company ?? "Unknown company"
    }
    
    public var wrappedEmail: String {
        return email ?? "Unknown email"
    }
    
    public var wrappedAddress: String {
        return address ?? "Unknown address"
    }
    
    public var wrappedFriends: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
