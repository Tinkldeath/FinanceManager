//
//  Settings+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 5.06.22.
//
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings")
    }

    @NSManaged public var monthReportNotifications: Bool
    @NSManaged public var debtsNotifications: Bool
    @NSManaged public var password: Bool
    @NSManaged public var encrypt: Bool
    @NSManaged public var backup: Bool

}

extension Settings : Identifiable {

}
