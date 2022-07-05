//
//  Microlan+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//
//

import Foundation
import CoreData

@objc(Microlan)
public class Microlan: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Microlan")!, insertInto: CoreDataManager.instance.context)
    }
    
    func presentInfo() -> String{
        return"""
        Microlan:
        \(self.watermark ?? "")
        Sum: \(NSString(format:"%.1f", self.sum)) \(UserDataManager.data.currency!)
        Payment per month: \(NSString(format:"%.1f", self.paymentSum)) \(UserDataManager.data.currency!)
        Organization(person): \(self.organization ?? "")
        Notifiaction day: \(self.paymentDate)
        """
    }
}
