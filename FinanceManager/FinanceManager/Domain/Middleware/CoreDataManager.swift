//
//  CoreDataManager.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let instance = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceManager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func entityForName(entityName: String) -> NSEntityDescription?{
        return NSEntityDescription.entity(forEntityName: entityName, in: context)
    }
    
    func clearContext(){
        UserDataManager.reset()
        CategoriesManager.reset()
        ExpenseManager.reset()
        BackupCodesManager.reset()
        BackupQuestionManager.reset()
        CarManager.reset()
        DebtsManager.reset()
        SettingsManager.reset()
    }
    
    func loadContext(){
        SettingsManager.load()
        UserDataManager.load()
        CategoriesManager.load()
        ExpenseManager.load()
        BackupCodesManager.load()
        BackupQuestionManager.load()
        CarManager.load()
        DebtsManager.load()
    }
    
}
