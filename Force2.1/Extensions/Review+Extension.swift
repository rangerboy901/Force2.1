//
//  Review+Extension.swift
//  Force2.1
//
//  Created by Joseph William DeWeese on 11/14/22.
//

import Foundation
import CoreData

extension Review: BaseModel {
    
    static func getReviewsByWorkoutId(workoutId: NSManagedObjectID) -> [Review] {
        
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "workout = %@", workoutId)
        
        do {
            return try CoreDataProvider.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
