//
//  ChartOptionsViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class ChartOptionsViewController: UIViewController, PPublisher {
    
    var subscribers: [PSubscriber] = [PSubscriber]()
    var selectedCategories = [String]()
    
    @IBOutlet var categoriesView: UITableView!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet var selectCategoriesSwitch: UISwitch!
    @IBOutlet var allCategoriesSwitch: UISwitch!
    @IBOutlet var priorityCategoriesSwitch: UISwitch!
    
    @IBOutlet var startDate: UIDatePicker!
    @IBOutlet var endDate: UIDatePicker!
    
    
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
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        let array = switches.filter({ $0 !== sender })
        for element in array{
            element.setOn(false, animated: true)
        }
        if sender === selectCategoriesSwitch{
            categoriesView.isHidden = false
        }else{
            categoriesView.isHidden = true
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if startDate.date == endDate.date{
            handleInputError(SInputError(localizedDescription: "The same date is unsupported", field: "Date"))
            return
        }else if startDate.date > endDate.date{
            handleInputError(SInputError(localizedDescription: "Incorrect date choices", field: "Date"))
            return
        }
        if allCategoriesSwitch.isOn{
            FinanceStrategyService.strategy?.setOptions(SChartSettings(startDate: startDate.date, endDate: endDate.date, categories: CategoriesManager.categories))
        }else if priorityCategoriesSwitch.isOn{
            var categories = [String]()
            for category in CategoriesManager.top{
                categories.append(category.category!)
            }
            FinanceStrategyService.strategy?.setOptions(SChartSettings(startDate: startDate.date, endDate: endDate.date, categories: categories))
        }else{
            FinanceStrategyService.strategy?.setOptions(SChartSettings(startDate: startDate.date, endDate: endDate.date, categories: selectedCategories))
        }
        notify()
        let ac = UIAlertController(title: "", message: "Options updated", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChartOptionsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesManager.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = CategoriesManager.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategories.append(CategoriesManager.categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCategories = selectedCategories.filter( { $0 != CategoriesManager.categories[indexPath.row] } )
    }
}
