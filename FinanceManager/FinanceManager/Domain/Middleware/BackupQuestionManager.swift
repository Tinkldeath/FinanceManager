//
//  BackupQuestionManager.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//

import Foundation

class BackupQuestionManager{
    
    private init() {}
    
    static private(set) var backupQuestion = BackupData()
    
    static func load(){
        do{
            if let result = try CoreDataManager.instance.context.fetch(BackupData.fetchRequest()).first{
                backupQuestion = result
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func useQuestion(_ answer: String) -> Bool{
        return backupQuestion.answer == answer
    }
    
    static func reset(){
        do{
            let results = try CoreDataManager.instance.context.fetch(BackupData.fetchRequest())
            for result in results {
                CoreDataManager.instance.context.delete(result)
            }
            CoreDataManager.instance.saveContext()
            backupQuestion = BackupData()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func setQuestion(_ question: String, _ answer: String) throws{
        if answer.isEmpty{
            throw SInputError(localizedDescription: "Empty string", field: "Backup Question")
        }
        reset()
        backupQuestion.question = question
        backupQuestion.answer = answer
        CoreDataManager.instance.saveContext()
    }
}
