//
//  StrategyViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class StrategyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toAccount(_ sender: Any) {
        let button = sender as! UIButton
        UserDataManager.setFinanceStrategy(button.titleLabel!.text!)
        if let _ = UserDataManager.data.name{
            let vc = storyboard?.instantiateViewController(withIdentifier: "AccountViewController")
            navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SuccessfullyRegisteredViewController")
            navigationController?.pushViewController(vc!, animated: true)
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
