//
//  UserDataBuilder.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import Foundation
import CoreData

class UserDataManager{
    
    private init() {}
    
    static private(set) var data = Userdata()
    static private var link = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
    static private let usd_eur = 1.0726
    
    static func load(){
        do{
            if let result = try CoreDataManager.instance.context.fetch(Userdata.fetchRequest()).first{
                data = result
                if let strategy = data.strategy{
                    if strategy == "Storage"{
                        FinanceStrategyService.setStrategy(StorageStrategy())
                    }else if strategy == "Investment"{
                        FinanceStrategyService.setStrategy(InvestmentStrategy())
                    }else if strategy == "Trading"{
                        FinanceStrategyService.setStrategy(TradingStrategy())
                    }else{
                        FinanceStrategyService.setStrategy(AccountingStrategy())
                    }
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func reset() {
        do{
            let results = try CoreDataManager.instance.context.fetch(Userdata.fetchRequest())
            for result in results {
                CoreDataManager.instance.context.delete(result)
            }
            CoreDataManager.instance.saveContext()
            data = Userdata()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func setPersonalData(_ name: String, _ password: String, _ salary: String, _ wishedSum: String, _ currency: String) throws{
        if name.isEmpty{
            throw SInputError(localizedDescription: "Empty string", field: "Name")
        }else if password.isEmpty{
            throw SInputError(localizedDescription: "Empty string", field: "Password")
        }else if salary.isEmpty{
            throw SInputError(localizedDescription: "Empty string", field: "Salary")
        }else if password.count < 5{
            throw SInputError(localizedDescription: "Password is too short", field: "Password")
        }
        if let sal = Double(salary){
            data = Userdata()
            if sal <= 0{
                throw SInputError(localizedDescription: "Invalid value", field: "Salary")
            }
            data.name = name
            data.password = password
            data.salary = sal
            data.currency = currency
            CoreDataManager.instance.saveContext()
        }else{
            throw SInputError(localizedDescription: "Invalid value", field: "Salary")
        }
        if let sum = Double(wishedSum){
            if sum <= 0{
                throw SInputError(localizedDescription: "Invalid value", field: "Sum to earn(save)")
            }
            data.wishedSum = sum
        }
        else{
            throw SInputError(localizedDescription: "Invalid value", field: "Sum to earn(save)")
        }
        CoreDataManager.instance.saveContext()
    }
    
    static func setFinanceStrategy(_ strategy: String){
        data.strategy = strategy
        CoreDataManager.instance.saveContext()
    }
    
    static func setTargetSum(_ sum: String) throws{
        if let s = Double(sum){
            if s <= 0{
                throw SInputError(localizedDescription: "Invalid value", field: "Target sum")
            }
            data.wishedSum = s
            CoreDataManager.instance.saveContext()
        }else{
            throw SInputError(localizedDescription: "Invalid value", field: "Target sum")
        }
    }
    
    static func changePassword(_ password: String) throws{
        if password.isEmpty{
            throw SInputError(localizedDescription: "Empty string", field: "Password")
        }else if password.count < 5{
            throw SInputError(localizedDescription: "Password is too short", field: "Password")
        }else{
            data.password = password
            CoreDataManager.instance.saveContext()
        }
    }
    
    static func changeCurrency(_ currency: String){
        if currency == data.currency{
            return
        }else if currency == "USD"{
            ExpenseManager.recount(self.usd_eur)
            DebtsManager.recount(self.usd_eur)
        }else{
            ExpenseManager.recount(1.0/self.usd_eur)
            DebtsManager.recount(1.0/self.usd_eur)
        }
        data.currency = currency
        CoreDataManager.instance.saveContext()
    }
    
    static func login(_ password: String) -> Bool{
        return data.password == password
    }
    
}
