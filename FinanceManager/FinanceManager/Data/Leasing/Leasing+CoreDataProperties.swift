//
//  Leasing+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//
//

import Foundation
import CoreData


extension Leasing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Leasing> {
        return NSFetchRequest<Leasing>(entityName: "Leasing")
    }

    @NSManaged public var watermark: String?
    @NSManaged public var organization: String?
    @NSManaged public var item: String?
    @NSManaged public var sum: Double
    @NSManaged public var paymentSum: Double
    @NSManaged public var paymentDate: Int16

}

extension Leasing : Identifiable {

}
