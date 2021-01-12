//
//  CoreDataManager.swift
//  CoreDataTraining
//
//  Created by Źmicier Fiedčanka on 11.01.21.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTrainingModels")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        return container
    }()
    
    
    func fetchCompanies() -> [Company]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let error {
            print("Failed to fetch companies:", error)
            return nil
        }
    }
    
    
    @objc func reset() {
        let context = persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
        } catch let deleteError {
            print("Failed to delete objects from Core Data: \(deleteError)")
        }
    }
    
    
    func createEmployee(name: String) -> Error? {
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        
        employee.setValue(name, forKey: "name")
        
        do {
            try context.save()
            return nil
        } catch let saveError {
            return saveError
        }
    }
}
