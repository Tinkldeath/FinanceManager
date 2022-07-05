//
//  BackupCodesManager.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//

import Foundation

class BackupCodesManager{
    
    private init() {}
    
    static private(set) var codes = [BackupCode]()
    
    static func load(){
        do{
            let results = try CoreDataManager.instance.context.fetch(BackupCode.fetchRequest())
            codes = results
            for code in codes{
                print(code.code!)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func generateCodes(){
        reset()
        codes.removeAll(keepingCapacity: true)
        for _ in 0..<5{
            let code = BackupCode()
            code.code = UUID().uuidString
            codes.append(code)
        }
    }
    
    static func useCode(_ codeString: String) -> Bool{
        for code in codes{
            if code.code == codeString{
                CoreDataManager.instance.context.delete(code)
                codes = codes.filter({ $0.code != codeString })
                CoreDataManager.instance.saveContext()
                return true
            }
        }
        return false
    }
    
    static func reset() {
        do{
            let results = try CoreDataManager.instance.context.fetch(BackupCode.fetchRequest())
            for result in results {
                CoreDataManager.instance.context.delete(result)
            }
            CoreDataManager.instance.saveContext()
            codes = []
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
