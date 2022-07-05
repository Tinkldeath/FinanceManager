//
//  Userdata+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//
//

import Foundation
import CoreData


extension Userdata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Userdata> {
        return NSFetchRequest<Userdata>(entityName: "Userdata")
    }

    @NSManaged public var currency: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var salary: Double
    @NSManaged public var strategy: String?
    @NSManaged public var wishedSum: Double
    @NSManaged public var encrypt: Bool

}

extension Userdata : Identifiable {

}
