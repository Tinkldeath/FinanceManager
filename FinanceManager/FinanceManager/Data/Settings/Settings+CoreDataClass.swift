//
//  Settings+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 5.06.22.
//
//

import Foundation
import CoreData

@objc(Settings)
public class Settings: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Settings")!, insertInto: CoreDataManager.instance.context)
    }
}
