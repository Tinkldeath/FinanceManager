//
//  LoginViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResetValidationViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if UserDataManager.login(passwordTF.text ?? ""){
            let vc = storyboard?.instantiateViewController(withIdentifier: "AccountViewController")
            navigationController?.pushViewController(vc!, animated: true)
        }else{
            handleInputError(SInputError(localizedDescription: "Passwords don't match", field: "Password"))
        }
    }

    func handleInputError(_ error: SInputError){
        let ac = UIAlertController(title: "Login failed", message: "\(error.localizedDescription)\n", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
