//
//  Music+CoreDataProperties.swift
//  funZone
//
//  Created by admin on 1/7/25.
//
//

import Foundation
import CoreData


extension Music {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Music> {
        return NSFetchRequest<Music>(entityName: "Music")
    }

    @NSManaged public var title: String?
    @NSManaged public var fileUrl: String?

}

extension Music : Identifiable {

}
