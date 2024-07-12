//
//  UserManager.swift
//  demo
//
//  Created by Emir Seçer on 9.07.2024.
//

import Foundation
import CoreData

class UserManager {
    static let shared = UserManager()
    
    private let context = PersistenceController.shared.container.viewContext
    
    func addUser(name: String, email: String, password: String, gpa: Double, attendance: Double) {
        let newUser = User(context: context)
        newUser.name = name
        newUser.email = email
        newUser.password = password
        newUser.gpa = gpa
        newUser.attendance = attendance
        
        saveContext()
    }
    
    func fetchUser(email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Fetch failed")

            return nil
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

