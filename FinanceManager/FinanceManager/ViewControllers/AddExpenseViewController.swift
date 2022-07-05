//
//  AddExpenseTableViewController.swift
//  FinanceManager
//
//  Created by Dima on 1.06.22.
//

import UIKit

class AddExpenseViewController: UIViewController, PPublisher{
    var subscribers: [PSubscriber] = [PSubscriber]()
    
    var selectedCategory: String = ""
    
    @IBOutlet var categoriesView: UITableView!
    @IBOutlet var watermarkTF: UITextField!
    @IBOutlet var sumTF: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesView.dataSource = self
        categoriesView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    deinit{
        for subscriber in subscribers{
            self.unsubscribe(subscriber)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        do{
            if watermarkTF.text == ""{
                try ExpenseManager.addExpense("Unmarked Expense", sumTF.text ?? "", datePicker.date, selectedCategory)
            }else{
                try ExpenseManager.addExpense(watermarkTF.text ?? "", sumTF.text ?? "", datePicker.date, selectedCategory)
            }
            let ac = UIAlertController(title: "", message: "Category added", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            notify()
        }catch{
            if let err = error as? SInputError{
                handleInputError(err)
            }
        }
    }
    
    func handleInputError(_ error: SInputError){
        let ac = UIAlertController(title: "Please check your input", message: "\(error.localizedDescription)\nField:\(error.field)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
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

extension AddExpenseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesManager.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = CategoriesManager.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = CategoriesManager.categories[indexPath.row]
    }
}
