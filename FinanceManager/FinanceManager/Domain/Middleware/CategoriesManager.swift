//
//  ExpensesManager.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//

import Foundation
import UIKit

class CategoriesManager{
    
    private init() {}
    
    static private(set) var top = [TopCategories]()
    
    static private(set) var categories = [
        "Household expenses",
        "Education expenses",
        "Transport expenses",
        "Oil expenses",
        "Shopping expenses",
        "Bad habits",
        "Internet shopping expenses",
        "Online games expenses",
        "Gambling expenses",
        "Entertainment expenses",
        "Fastfood expenses",
        "Service expenses",
        "Investment",
        "Trade",
        "Credit payment",
        "Leasing payment",
        "Microlan payment",
        "Other expenses"
    ]
    
    static func load(){
        do{
            let results = try CoreDataManager.instance.context.fetch(TopCategories.fetchRequest()).sorted(by: { $0.rating < $1.rating })
            top = results
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func setTop(_ top: [TopCategories]){
        if self.top.isEmpty{
            self.top = top
        }
        else{
            reset()
            self.top = top
        }
        CoreDataManager.instance.saveContext()
    }
    
    static func reset(){
        top.removeAll(keepingCapacity: true)
        do{
            let results = try CoreDataManager.instance.context.fetch(TopCategories.fetchRequest())
            for result in results {
                CoreDataManager.instance.context.delete(result)
            }
            top = []
            CoreDataManager.instance.saveContext()
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
