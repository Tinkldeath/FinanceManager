//
//  Expense+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var watermark: String?
    @NSManaged public var sum: Double
    @NSManaged public var category: String?
    @NSManaged public var date: Date?

}

extension Expense : Identifiable {

}
