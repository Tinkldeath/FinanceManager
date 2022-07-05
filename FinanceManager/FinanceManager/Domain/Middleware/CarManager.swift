//
//  File.swift
//  FinanceManager
//
//  Created by Dima on 1.06.22.
//

import Foundation

class CarManager{
    
    private init() {}
    
    static private(set) var car = Car()
    
    static func load(){
        do{
            if let result = try CoreDataManager.instance.context.fetch(Car.fetchRequest()).first{
                car = result
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func setCar(_ model: String, _ fuel: String, _ distance: String) throws{
        if let f = Double(fuel){
            if f <= 0{
                throw SInputError(localizedDescription: "Incorrect input", field: "Average fuel consumption")
            }
            car.fuel = f
        }else{
            throw SInputError(localizedDescription: "Incorrect input", field: "Average fuel consumption")
        }
        
        if let d = Double(distance){
            if d <= 0{
                throw SInputError(localizedDescription: "Incorrect input", field: "Average distance per day")
            }
            car.distance = d
        }else{
            throw SInputError(localizedDescription: "Incorrect input", field: "Average distance per day")
        }
        if model.isEmpty{
            throw SInputError(localizedDescription: "Empty string", field: "Model")
        }
        CoreDataManager.instance.saveContext()
    }
    
    static func reset(){
        do{
            let results = try CoreDataManager.instance.context.fetch(Car.fetchRequest())
            for result in results {
                CoreDataManager.instance.context.delete(result)
            }
            CoreDataManager.instance.saveContext()
            car = Car()
        }catch{
            print(error.localizedDescription)
        }
    }
}
