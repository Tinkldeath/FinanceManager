//
//  ExpenseManager.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//

import Foundation

class ExpenseManager{
    
    static private(set) var expenses = [Expense]()
    
    private init() {}
    
    static func load() {
        do{
            let results = try CoreDataManager.instance.context.fetch(Expense.fetchRequest())
            expenses = results
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func reset() {
        do{
            let results = try CoreDataManager.instance.context.fetch(Expense.fetchRequest())
            for result in results {
                CoreDataManager.instance.context.delete(result)
            }
            CoreDataManager.instance.saveContext()
            expenses = []
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func addExpense(_ watermark: String, _ sum: String, _ date: Date, _ category: String) throws{
        if category.isEmpty{
            throw SInputError(localizedDescription: "Category is not selected", field: "Category")
        }
        if let s = Double(sum){
            if s <= 0{
                throw SInputError(localizedDescription: "Invalid value", field: "Sum")
            }
            let expense = Expense()
            expense.watermark = watermark
            expense.sum = s
            expense.date = date
            expense.category = category
            expenses.append(expense)
            CoreDataManager.instance.saveContext()
        }else{
            throw SInputError(localizedDescription: "Invalid value", field: "Sum")
        }
    }
    
    static func removeExpense(_ index: Int){
        if index >= expenses.count{
            return
        }else{
            CoreDataManager.instance.context.delete(expenses[index])
            expenses.remove(at: index)
            CoreDataManager.instance.saveContext()
        }
    }
    
    static func recount(_ newValue: Double){
        for expense in expenses{
            expense.sum *= newValue
        }
        CoreDataManager.instance.saveContext()
    }
}
