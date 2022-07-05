//
//  Credit+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//
//

import Foundation
import CoreData


extension Credit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Credit> {
        return NSFetchRequest<Credit>(entityName: "Credit")
    }

    @NSManaged public var watermark: String?
    @NSManaged public var bank: String?
    @NSManaged public var sum: Double
    @NSManaged public var paymentSum: Double
    @NSManaged public var paymentDate: Int16

}

extension Credit : Identifiable {

}
