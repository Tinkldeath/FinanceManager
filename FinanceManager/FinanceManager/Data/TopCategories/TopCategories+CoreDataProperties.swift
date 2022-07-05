//
//  TopCategories+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//
//

import Foundation
import CoreData


extension TopCategories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopCategories> {
        return NSFetchRequest<TopCategories>(entityName: "TopCategories")
    }

    @NSManaged public var rating: Int16
    @NSManaged public var category: String?

}

extension TopCategories : Identifiable {

}
