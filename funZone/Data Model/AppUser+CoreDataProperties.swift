//
//  AppUser+CoreDataProperties.swift
//  funZone
//
//  Created by admin on 1/13/25.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension AppUser : Identifiable {

}
