//
//  ViewController.swift
//  FinanceManager
//
//  Created by Dima on 23.05.22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var nameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var repeatPasswordTF: UITextField!
    @IBOutlet var salaryTF: UITextField!
    @IBOutlet var currencySegment: UISegmentedControl!
    @IBOutlet var questionTF: UITextField!
    @IBOutlet var wishSumTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueClicked(_ sender: Any) {
        if passwordTF.text != repeatPasswordTF.text{
            handleInputError(SInputError(localizedDescription: "Passwords don't match", field: "Password"))
        }
        do{
            try UserDataManager.setPersonalData(nameTF.text ?? "", passwordTF.text ?? "", salaryTF.text ?? "", wishSumTF.text ?? "" ,currencySegment.titleForSegment(at: currencySegment.selectedSegmentIndex) ?? "")
            try BackupQuestionManager.setQuestion(questionTF.placeholder ?? "", questionTF.text ?? "")
            let vc = storyboard?.instantiateViewController(withIdentifier: "CarViewController")
            navigationController?.pushViewController(vc!, animated: true)
        }catch{
            if let err = error as? SInputError{
                handleInputError(err)
            }
        }
    }
    
    func handleInputError(_ error: SInputError){
        let ac = UIAlertController(title: "Please, check your input", message: "Field: \(error.field)\n Reason: \(error.localizedDescription)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}

