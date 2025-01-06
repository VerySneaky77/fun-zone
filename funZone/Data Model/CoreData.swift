//
//  CoreData.swift
//  funZone
//
//  Created by admin on 1/6/25.
//

import CoreData

class CoreDataStack : ObservableObject {
    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "appData")
    
        container.loadPersistentStores(completionHandler: {(appDescription, error) in
            if let error = error as NSError?{
                print("No data loaded")
                return
            }
        })
        return container
    }()
}
