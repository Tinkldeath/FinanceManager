//
//  BackupCode+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//
//

import Foundation
import CoreData


extension BackupCode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BackupCode> {
        return NSFetchRequest<BackupCode>(entityName: "BackupCode")
    }

    @NSManaged public var code: String?

}

extension BackupCode : Identifiable {

}
