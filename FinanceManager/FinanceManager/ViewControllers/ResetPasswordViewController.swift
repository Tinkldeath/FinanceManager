//
//  ResetPasswordViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var repeatTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if passwordTF.hasText && repeatTF.hasText{
            if passwordTF.text! != repeatTF.text{
                handleInputError(SInputError(localizedDescription: "Passwords don't match", field: "Password"))
                return
            }
        }
        do{
            try UserDataManager.changePassword(passwordTF.text!)
            navigationController?.popToRootViewController(animated: true)
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
