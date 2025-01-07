//
//  Book+CoreDataProperties.swift
//  funZone
//
//  Created by admin on 1/7/25.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?

}

extension Book : Identifiable {

}
