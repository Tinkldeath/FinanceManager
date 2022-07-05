//
//  ResetValidationViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class ResetValidationViewController: UIViewController {

    @IBOutlet var questionTF: UITextField!
    @IBOutlet var codeTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        if questionTF.hasText{
            if BackupQuestionManager.useQuestion(questionTF.text!){
                let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController")
                navigationController?.pushViewController(vc!, animated: true)
            }
        }else if codeTF.hasText{
            if BackupCodesManager.useCode(codeTF.text!){
                let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController")
                navigationController?.pushViewController(vc!, animated: true)
            }
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
