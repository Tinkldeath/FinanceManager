//
//  Car+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//
//

import Foundation
import CoreData

@objc(Car)
public class Car: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Car")!, insertInto: CoreDataManager.instance.context)
    }
}
