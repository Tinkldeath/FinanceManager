//
//  Leasing+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//
//

import Foundation
import CoreData

@objc(Leasing)
public class Leasing: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Leasing")!, insertInto: CoreDataManager.instance.context)
    }
    
    func presentInfo() -> String{
        return"""
        Leasing:
        \(self.watermark ?? "")
        Sum: \(NSString(format:"%.1f", self.sum)) \(UserDataManager.data.currency!)
        Payment per month: \(NSString(format:"%.1f", self.paymentSum)) \(UserDataManager.data.currency!)
        Organization(person): \(self.organization ?? "")
        Notifiaction day: \(self.paymentDate)
        Item: \(self.item ?? "")
        """
    }
}
