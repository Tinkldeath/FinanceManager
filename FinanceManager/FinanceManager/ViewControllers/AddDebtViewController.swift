//
//  AddDebtViewController.swift
//  FinanceManager
//
//  Created by Dima on 4.06.22.
//

import UIKit

class AddDebtViewController: UIViewController, PPublisher {
    
    var currentType: EDebtType = .Credit
    var subscribers: [PSubscriber] = [PSubscriber]()

    @IBOutlet var typeSegment: UISegmentedControl!
    
    @IBOutlet var watermarkTF: UITextField!
    @IBOutlet var sumTF: UITextField!
    @IBOutlet var monthsTF: UITextField!
    @IBOutlet var organizationTF: UITextField!
    @IBOutlet var itemTF: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemTF.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    deinit{
        for subscriber in subscribers{
            self.unsubscribe(subscriber)
        }
    }
    
    @IBAction func segmentDidChange(_ sender: Any) {
        if typeSegment.selectedSegmentIndex == 0{
            currentType = .Credit
        }else if typeSegment.selectedSegmentIndex == 1{
            currentType = .Leasing
        }else{
            currentType = .Microlan
        }
        itemTF.isHidden = currentType != .Leasing
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func handleInputError(_ error: SInputError){
        let ac = UIAlertController(title: "Please check your input", message: "\(error.localizedDescription)\nField:\(error.field)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        do{
            if watermarkTF.text == ""{
                try DebtsManager.addDebt(currentType, "Unmarked debt", sumTF.text ?? "", monthsTF.text ?? "", Double(datePicker.date.get(.day)), organizationTF.text ?? "", itemTF.text ?? "")
            }else{
                try DebtsManager.addDebt(currentType, watermarkTF.text ?? "", sumTF.text ?? "", monthsTF.text ?? "", Double(datePicker.date.get(.day)), organizationTF.text ?? "", itemTF.text ?? "")
            }
            let ac = UIAlertController(title: "", message: "Debt added", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            notify()
        }catch{
            if let err = error as? SInputError{
                handleInputError(err)
            }
        }
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

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
