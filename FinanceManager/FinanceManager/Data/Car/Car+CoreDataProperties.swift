//
//  Car+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 29.05.22.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var model: String?
    @NSManaged public var distance: Double
    @NSManaged public var fuel: Double

}

extension Car : Identifiable {

}
