//
//  Note+CoreDataProperties.swift
//  funZone
//
//  Created by admin on 1/9/25.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var content: String?

}

extension Note : Identifiable {

}
