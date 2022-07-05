//
//  BackupData+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//
//

import Foundation
import CoreData

@objc(BackupData)
public class BackupData: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "BackupData")!, insertInto: CoreDataManager.instance.context)
    }
}
