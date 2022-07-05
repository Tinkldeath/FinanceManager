//
//  AccountViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class AccountViewController: UIViewController, PSubscriber{
  
    var selectedIndex: Int?
    
    @IBOutlet var expenseView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expenseView.dataSource = self
        expenseView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        vc.subscribe(self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func debtsClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DebtsViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func statisticsClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StatisticsViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddExpenseViewController") as! AddExpenseViewController
        vc.subscribe(self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        if let selectedIndex = selectedIndex {
            ExpenseManager.removeExpense(selectedIndex)
            update()
        }
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        if let selectedIndex = selectedIndex {
            presentInfo(ExpenseManager.expenses[selectedIndex].presentInfo())
        }
    }
    
    func presentInfo(_ info: String){
        let ac = UIAlertController(title: "Info", message: info, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func update() {
        expenseView.reloadData()
    }

}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExpenseManager.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = ExpenseManager.expenses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)
        cell.textLabel?.text = "\(expense.watermark!)"
        cell.detailTextLabel?.text = "\(NSString(format:"%.1f", expense.sum)) \(UserDataManager.data.currency!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}
