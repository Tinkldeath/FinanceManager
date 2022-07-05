//
//  SettingsTableViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class SettingsViewController: UITableViewController, PPublisher {
    
    var subscribers: [PSubscriber] = [PSubscriber]()
    
    @IBOutlet var monthReportSwitch: UISwitch!
    @IBOutlet var debtsNotificationSwitch: UISwitch!
    @IBOutlet var passwordSwitch: UISwitch!
    @IBOutlet var encryptSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthReportSwitch.setOn(SettingsManager.settings.monthReportNotifications, animated: false)
        debtsNotificationSwitch.setOn(SettingsManager.settings.debtsNotifications, animated: false)
        passwordSwitch.setOn(SettingsManager.settings.password, animated: false)
        encryptSwitch.setOn(SettingsManager.settings.encrypt, animated: false)
    }
    
    @IBAction func monthReportSwitchChanged(_ sender: UISwitch) {
        SettingsManager.setMonthNotifications(sender.isOn)
    }
    
    @IBAction func debtsReportSwitchChanged(_ sender: UISwitch) {
        SettingsManager.setDebtsNotifications(sender.isOn)
    }
    
    @IBAction func passwordSwitchChanged(_ sender: UISwitch) {
        SettingsManager.setPassword(sender.isOn)
    }
    
    @IBAction func encryptSwitchChanged(_ sender: UISwitch) {
        SettingsManager.setEncrypt(sender.isOn)
    }
    
    @IBAction func changeCurrencyClick(_ sender: Any) {
        let ac = UIAlertController(title: "Select one", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "USD", style: .default){ _ in
            UserDataManager.changeCurrency("USD")
            self.notify()
        })
        ac.addAction(UIAlertAction(title: "EUR", style: .default){ _ in
            UserDataManager.changeCurrency("EUR")
            self.notify()
        })
        present(ac, animated: true)
    }
    
    
    @IBAction func changeSumClicked(_ sender: Any) {
        let ac = UIAlertController(title: "Target sum", message: "", preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?.first!.placeholder = "New sum (\(UserDataManager.data.currency!))"
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            do{
                try UserDataManager.setTargetSum(ac.textFields?.first!.text ?? "")
            }catch{
                return
            }
        }))
        present(ac, animated: true)
    }
    
    @IBAction func changeSalaryClicked(_ sender: Any){
        let ac = UIAlertController(title: "Salary", message: "", preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?.first!.placeholder = "New salary (\(UserDataManager.data.currency!))"
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            do{
                try UserDataManager.setTargetSum(ac.textFields?.first!.text ?? "")
            }catch{
                return
            }
        }))
        present(ac, animated: true)
    }
    
    @IBAction func changeStrategyClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StrategyViewController")
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController")
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(vc!, animated: true)
    }
    

    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        let ac = UIAlertController(title: "Warning", message: "This action will delete your data permanently (including backup copy). Continue?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
            CoreDataManager.instance.clearContext()
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }))
        
        ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    @IBAction func changeCarClicked(_ sender: Any) {
        CarManager.reset()
        let vc = storyboard?.instantiateViewController(withIdentifier: "CarViewController") as! CarViewController
        vc.fromSettings = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changeCategoriesClicked(_ sender: Any) {
        CategoriesManager.reset()
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController")
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func subscribe(_ subscriber: PSubscriber) {
        subscribers.append(subscriber)
    }
    
    func unsubscribe(_ subscriber: PSubscriber) {
        if let index = subscribers.firstIndex(where: { $0 === subscriber }){
            subscribers.remove(at: index)
        }
    }
    
    func notify() {
        for subscriber in subscribers{
            subscriber.update()
        }
    }
    
}
