//
//  SuccessfullyRegisteredViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit
import Foundation

class SuccessfullyRegisteredViewController: UIViewController {
    
    @IBOutlet var codes: [UITextField]!
    @IBOutlet var copyButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackupCodesManager.generateCodes()
        var i = 0
        for code in codes{
            code.text = BackupCodesManager.codes[i].code
            i += 1
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func copyClicked(_ sender: UIButton) {
        if let buttonIndex = copyButtons.firstIndex(of: sender){
            UIPasteboard.general.string = codes[buttonIndex].text
            let alert = UIAlertController(title: "", message: "Code copied to clipboard", preferredStyle: .actionSheet)
            present(alert, animated: true)
            alert.dismiss(animated: true)
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
