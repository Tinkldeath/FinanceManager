//
//  DebtsManager.swift
//  FinanceManager
//
//  Created by Dima on 4.06.22.
//

import Foundation

enum EDebtType{
    case Credit, Leasing, Microlan
}

class DebtsManager{
    
    static private(set) var credits = [Credit]()
    static private(set) var microlans = [Microlan]()
    static private(set) var leasings = [Leasing]()
    
    private init() {}
    
    static func load(){
        do{
            let credits = try CoreDataManager.instance.context.fetch(Credit.fetchRequest())
            self.credits = credits
            let microlans = try CoreDataManager.instance.context.fetch(Microlan.fetchRequest())
            self.microlans = microlans
            let leasings = try CoreDataManager.instance.context.fetch(Leasing.fetchRequest())
            self.leasings = leasings
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func reset(){
        do{
            let credits = try CoreDataManager.instance.context.fetch(Credit.fetchRequest())
            let microlans = try CoreDataManager.instance.context.fetch(Microlan.fetchRequest())
            let leasings = try CoreDataManager.instance.context.fetch(Leasing.fetchRequest())
            
            for credit in credits {
                CoreDataManager.instance.context.delete(credit)
            }
            for microlan in microlans {
                CoreDataManager.instance.context.delete(microlan)
            }
            for leasing in leasings {
                CoreDataManager.instance.context.delete(leasing)
            }
            self.credits = []
            self.leasings = []
            self.microlans = []
            CoreDataManager.instance.saveContext()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func addDebt(_ type: EDebtType, _ watermark: String, _ sum: String, _ months: String, _ date: Double, _ organization: String, _ item: String) throws{
        if organization == ""{
            throw SInputError(localizedDescription: "Empty string", field: "Organization(person)")
        }
        switch type {
        case .Credit:
            if valid(sum) == false{
                throw SInputError(localizedDescription: "Invalid value", field: "Sum")
            }else if valid(months) == false{
                throw SInputError(localizedDescription: "Invalid value", field: "Months")
            }else{
                let credit = Credit()
                credit.watermark = watermark
                credit.sum = Double(sum)!
                credit.paymentDate = Int16(date)
                credit.bank = organization
                credit.paymentSum = credit.sum/Double(months)!
                credits.append(credit)
                break
            }
        case .Leasing:
            if valid(sum) == false{
                throw SInputError(localizedDescription: "Invalid value", field: "Sum")
            }else if valid(months) == false{
                throw SInputError(localizedDescription: "Invalid value", field: "Months")
            }else{
                let leasing = Leasing()
                leasing.watermark = watermark
                leasing.sum = Double(sum)!
                leasing.paymentDate = Int16(date)
                leasing.organization = organization
                leasing.paymentSum = leasing.sum/Double(months)!
                leasing.item = item
                leasings.append(leasing)
                break
            }
        case .Microlan:
            if valid(sum) == false{
                throw SInputError(localizedDescription: "Invalid value", field: "Sum")
            }else if valid(months) == false{
                throw SInputError(localizedDescription: "Invalid value", field: "Months")
            }else{
                let microlan = Microlan()
                microlan.watermark = watermark
                microlan.sum = Double(sum)!
                microlan.paymentDate = Int16(date)
                microlan.organization = organization
                microlan.paymentSum = microlan.sum/Double(months)!
                microlans.append(microlan)
                break
            }
        }
        CoreDataManager.instance.saveContext()
    }
    
    static func removeDebt(_ type: EDebtType, _ index: Int){
        switch type {
        case .Credit:
            if index >= credits.count{
                return
            }else{
                CoreDataManager.instance.context.delete(credits[index])
                credits.remove(at: index)
                break
            }
        case .Leasing:
            if index >= leasings.count{
                return
            }else{
                CoreDataManager.instance.context.delete(leasings[index])
                leasings.remove(at: index)
                break
            }
        case .Microlan:
            if index >= microlans.count{
                return
            }else{
                CoreDataManager.instance.context.delete(microlans[index])
                microlans.remove(at: index)
                break
            }
        }
        CoreDataManager.instance.saveContext()
    }
    
    static private func valid(_ sum: String) -> Bool{
        if let s = Double(sum){
            if s <= 0{
                return false
            }else{
                return true
            }
        }
        return false
    }
    
    static func recount(_ newValue: Double){
        for credit in credits{
            credit.sum *= newValue
        }
        for microlan in microlans{
            microlan.sum *= newValue
        }
        for leasing in leasings{
            leasing.sum *= newValue
        }
        CoreDataManager.instance.saveContext()
    }
}
