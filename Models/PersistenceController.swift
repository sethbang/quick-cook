//
//  PersistenceController.swift
//  QuickCook
//
//  Created by Seth Bangert on 9/19/22.
//

import Foundation
import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QuickCook")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading stores: \(error)")
            }
        }
        return container
    }()
    
    private init() { }
        public func saveContext(backgroundContext: NSManagedObjectContext? = nil) throws {
            let context = backgroundContext ?? container.viewContext
            guard context.hasChanges else { return }
            try context.save()
        
    }
}
