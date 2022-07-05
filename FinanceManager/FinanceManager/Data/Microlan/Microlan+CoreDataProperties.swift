//
//  Microlan+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//
//

import Foundation
import CoreData


extension Microlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Microlan> {
        return NSFetchRequest<Microlan>(entityName: "Microlan")
    }

    @NSManaged public var watermark: String?
    @NSManaged public var organization: String?
    @NSManaged public var sum: Double
    @NSManaged public var paymentSum: Double
    @NSManaged public var paymentDate: Int16

}

extension Microlan : Identifiable {

}
