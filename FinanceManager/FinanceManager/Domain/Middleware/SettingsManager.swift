//
//  SettingsManager.swift
//  FinanceManager
//
//  Created by Dima on 5.06.22.
//

import Foundation

class SettingsManager{
    
    static private(set) var settings = Settings()
    
    private init() {}
    
    static func load(){
        do{
            if let result = try CoreDataManager.instance.context.fetch(Settings.fetchRequest()).first{
                settings = result
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func reset(){
        do{
            if let result = try CoreDataManager.instance.context.fetch(Settings.fetchRequest()).first{
                CoreDataManager.instance.context.delete(result)
            }
            CoreDataManager.instance.saveContext()
            settings = Settings()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func setPassword(_ password: Bool){
        settings.password = password
        CoreDataManager.instance.saveContext()
    }
    
    static func setEncrypt(_ encrypt: Bool){
        settings.encrypt = encrypt
        CoreDataManager.instance.saveContext()
    }
    
    static func setMonthNotifications(_ notifications: Bool){
        settings.monthReportNotifications = notifications
        CoreDataManager.instance.saveContext()
    }
    
    static func setDebtsNotifications(_ notifications: Bool){
        settings.debtsNotifications = notifications
        CoreDataManager.instance.saveContext()
    }
    
    static func setBackup(_ backup: Bool){
        settings.backup = backup
        CoreDataManager.instance.saveContext()
    }
}
