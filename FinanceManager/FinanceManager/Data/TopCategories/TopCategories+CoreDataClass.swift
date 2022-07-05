//
//  TopCategories+CoreDataClass.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//
//

import Foundation
import CoreData

@objc(TopCategories)
public class TopCategories: NSManagedObject {
    convenience init(){
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "TopCategories")!, insertInto: CoreDataManager.instance.context)
    }
}
