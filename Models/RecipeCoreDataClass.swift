//
//  RecipeCoreDataClass.swift
//  QuickCook
//
//  Created by Seth Bangert on 9/19/22.
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
    
    @nonobjc class func fetchRequest(forID id: UUID) -> NSFetchRequest<Recipe> {
        let request = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        return request
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var text: String
}
