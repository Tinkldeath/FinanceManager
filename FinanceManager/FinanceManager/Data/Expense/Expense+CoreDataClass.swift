//
//  Expense+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//
//

import Foundation
import CoreData

@objc(Expense)
public class Expense: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Expense")!, insertInto: CoreDataManager.instance.context)
    }
    
    func presentInfo() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return"""
        \(self.watermark!)
        Sum: \(NSString(format:"%.1f", self.sum)) \(UserDataManager.data.currency!)
        Category: \(self.category!)
        Date: \(formatter.string(from: self.date!))
        """
    }
}
