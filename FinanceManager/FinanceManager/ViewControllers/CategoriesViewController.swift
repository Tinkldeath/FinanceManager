//
//  CategoriesViewController.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//

import UIKit

class CategoriesViewController: UIViewController {

    var selectedTopCategory: UIButton?
    var selectedCategories = [UIButton]()
    
    @IBOutlet var topCategories: [UIButton]!
    @IBOutlet var categories: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func topCategoryClicked(_ sender: UIButton) {
        if let selectedTopCategory = selectedTopCategory {
            selectedTopCategory.backgroundColor = UIColor.lightGray
            sender.backgroundColor = UIColor.tintColor
            self.selectedTopCategory = sender
        }else{
            selectedTopCategory = sender
            sender.backgroundColor = UIColor.tintColor
        }
        let cats = topCategories.filter({ $0 !== sender })
        for cat in cats{
            cat.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func categoryClicked(_ sender: UIButton) {
        if let selectedTopCategory = selectedTopCategory{
            if var selectedTopCategoryTitle = selectedTopCategory.titleLabel!.text{
                if selectedTopCategoryTitle.count > 2{
                    return
                }else{
                    selectedTopCategoryTitle += sender.titleLabel!.text!
                    selectedTopCategory.setTitle(selectedTopCategoryTitle, for: .normal)
                    sender.isEnabled = false
                    selectedCategories.append(sender)
                }
            }
        }else {
            return
        }
    }
    @IBAction func resetClicked(_ sender: Any) {
        var i = 1
        for button in topCategories{
            button.setTitle("\(i).", for: .normal)
            button.backgroundColor = UIColor.lightGray
            i += 1
        }
        for button in selectedCategories{
            button.isEnabled = true
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        var newTop = [TopCategories]()
        
        for button in topCategories{
            let category = button.titleLabel!.text!
            if category.count < 3{
                return
            }else{
                let array = category.split(separator: ".")
                let top = TopCategories()
                top.category = String(array[1])
                top.rating = Int16(array[0])!
                newTop.append(top)
            }
        }
        CategoriesManager.setTop(newTop.sorted(by: { $0.rating < $1.rating }))
        let vc = storyboard?.instantiateViewController(withIdentifier: "AccountViewController")
        navigationController?.pushViewController(vc!, animated: true)
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
