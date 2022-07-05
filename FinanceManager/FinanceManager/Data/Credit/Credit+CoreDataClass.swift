//
//  Credit+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//
//

import Foundation
import CoreData

@objc(Credit)
public class Credit: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Credit")!, insertInto: CoreDataManager.instance.context)
    }
    
    func presentInfo() -> String{
        return"""
        Credit:
        \(self.watermark ?? "")
        Sum: \(NSString(format:"%.1f", self.sum))\(UserDataManager.data.currency!)
        Payment per month: \(NSString(format:"%.1f", self.paymentSum)) \(UserDataManager.data.currency!)
        Bank: \(self.bank ?? "")
        Notifiaction day: \(self.paymentDate)
        """
    }
}
