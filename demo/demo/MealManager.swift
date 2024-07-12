//
//  MealManager.swift
//  demo
//
//  Created by Emir Seçer on 9.07.2024.
//

import Foundation
import SwiftUI
import CoreData

class MealManager {
    static let shared = MealManager()
    
    private let context = PersistenceController.shared.container.viewContext
    
    func addMeal(date: String, meal: String) {
        let newMeal = Meal(context: context)
        newMeal.date = date
        newMeal.meal = meal
        
        saveContext()
    }
    
    func fetchMeals(for date: String) -> [Meal] {
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", date)
        
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed")
            return []
        }
    }
    
    private func saveContext() {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
