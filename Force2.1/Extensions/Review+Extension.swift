//
//  Review+Extension.swift
//  Force2.1
//
//  Created by Joseph William DeWeese on 11/14/22.
//

import Foundation
import CoreData

extension Review: BaseModel {
    
    static func getReviewsByMovieId(workoutId: NSManagedObjectID) -> [Review] {
        
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "movie = %@", workoutId)
        
        do {
            return try CoreDataProvider.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
