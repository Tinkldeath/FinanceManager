//
//  DebtsViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit

class DebtsViewController: UIViewController, PSubscriber{
   
    var selectedIndex: Int?
    
    @IBOutlet var typeSegment: UISegmentedControl!
    @IBOutlet var debtsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debtsTable.dataSource = self
        debtsTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDebtViewController") as! AddDebtViewController
        vc.subscribe(self)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func segmentDidChange(_ sender: Any) {
        selectedIndex = nil
        debtsTable.reloadData()
    }
    
    @IBAction func removeClicked(_ sender: Any) {
        if let selectedIndex = selectedIndex {
            if typeSegment.selectedSegmentIndex == 0{
                DebtsManager.removeDebt(.Credit, selectedIndex)
            }else if typeSegment.selectedSegmentIndex == 1{
                DebtsManager.removeDebt(.Leasing, selectedIndex)
            }else if typeSegment.selectedSegmentIndex == 2{
                DebtsManager.removeDebt(.Microlan, selectedIndex)
            }else{
                return
            }
            update()
        }
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        if let selectedIndex = selectedIndex {
            if typeSegment.selectedSegmentIndex == 0{
                presentInfo(DebtsManager.credits[selectedIndex].presentInfo())
            }else if typeSegment.selectedSegmentIndex == 1{
                presentInfo(DebtsManager.leasings[selectedIndex].presentInfo())
            }else if typeSegment.selectedSegmentIndex == 2{
                presentInfo(DebtsManager.microlans[selectedIndex].presentInfo())
            }else{
                return
            }
        }
    }
    
    func presentInfo(_ info: String){
        let ac = UIAlertController(title: "Info", message: info, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func update() {
        debtsTable.reloadData()
    }
}

extension DebtsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeSegment.selectedSegmentIndex == 0{
            return DebtsManager.credits.count
        }else if typeSegment.selectedSegmentIndex == 1{
            return DebtsManager.leasings.count
        }else if typeSegment.selectedSegmentIndex == 2{
            return DebtsManager.microlans.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtCell", for: indexPath)
        if typeSegment.selectedSegmentIndex == 0{
            cell.textLabel?.text = "\(DebtsManager.credits[indexPath.row].watermark!)"
            cell.detailTextLabel?.text = "\(DebtsManager.credits[indexPath.row].sum) \(UserDataManager.data.currency!)"
        }else if typeSegment.selectedSegmentIndex == 1{
            cell.textLabel?.text = "\(DebtsManager.leasings[indexPath.row].watermark!)"
            cell.detailTextLabel?.text = "\(DebtsManager.leasings[indexPath.row].sum) \(UserDataManager.data.currency!)"
        }else if typeSegment.selectedSegmentIndex == 2{
            cell.textLabel?.text = "\(DebtsManager.microlans[indexPath.row].watermark!)"
            cell.detailTextLabel?.text = "\(DebtsManager.microlans[indexPath.row].sum) \(UserDataManager.data.currency!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}
