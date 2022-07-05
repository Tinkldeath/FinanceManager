//
//  Userdata+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//
//

import Foundation
import CoreData

@objc(Userdata)
public class Userdata: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Userdata")!, insertInto: CoreDataManager.instance.context)
    }
}
