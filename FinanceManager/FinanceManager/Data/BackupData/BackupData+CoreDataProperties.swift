//
//  BackupData+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//
//

import Foundation
import CoreData


extension BackupData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BackupData> {
        return NSFetchRequest<BackupData>(entityName: "BackupData")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?

}

extension BackupData : Identifiable {

}
