//
//  BackupCode+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//
//

import Foundation
import CoreData

@objc(BackupCode)
public class BackupCode: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "BackupCode")!, insertInto: CoreDataManager.instance.context)
    }
}
