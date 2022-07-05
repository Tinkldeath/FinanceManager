//
//  CarViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class CarViewController: UIViewController {

    var fromSettings: Bool = false
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var distanceTF: UITextField!
    @IBOutlet var fuelTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        do{
            try CarManager.setCar(nameTF.text ?? "", fuelTF.text ?? "", distanceTF.text ?? "")
            if fromSettings{
                let vc = storyboard?.instantiateViewController(withIdentifier: "AccountViewController")
                navigationController?.pushViewController(vc!, animated: true)
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "StrategyViewController")
                navigationController?.pushViewController(vc!, animated: true)
            }
        }catch{
            if let err = error as? SInputError{
                handleInputError(err)
            }
        }
    }
    
    @IBAction func skipClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StrategyViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func handleInputError(_ error: SInputError){
        let ac = UIAlertController(title: "Please, check your input", message: "Field: \(error.field)\n Reason: \(error.localizedDescription)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}
