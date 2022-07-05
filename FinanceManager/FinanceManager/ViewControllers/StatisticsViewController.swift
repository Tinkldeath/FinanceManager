//
//  StatisticsViewController.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController, PSubscriber {
    
    
    @IBOutlet var chartView: PieChartView!
    
    @IBOutlet var statisticsText: UITextView!
    @IBOutlet var sumText: UILabel!
    @IBOutlet var typeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.data = FinanceStrategyService.strategy?.commonChart() as? ChartData
        statisticsText.text = FinanceStrategyService.strategy?.statistics()
        if let _ = FinanceStrategyService.strategy?.options{
            sumText.text = "Expense sum: \(NSString(format:"%.1f", FinanceStrategyService.strategy?.sum() ?? 0)) \(UserDataManager.data.currency!)"
        }else{
            sumText.text = ""
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func typeSegmentDidChange(_ sender: Any) {
        if typeSegment.selectedSegmentIndex == 0{
            statisticsText.text = FinanceStrategyService.strategy?.statistics()
        }else if typeSegment.selectedSegmentIndex == 1{
            statisticsText.text = FinanceStrategyService.strategy?.detailedStatistics()
        }else if typeSegment.selectedSegmentIndex == 2{
            statisticsText.text = FinanceStrategyService.strategy?.tips()
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChartOptionsViewController") as! ChartOptionsViewController
        vc.subscribe(self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func update() {
        if let options = FinanceStrategyService.strategy?.options{
            FinanceStrategyService.strategy?.setOptions(options)
            chartView.data = FinanceStrategyService.strategy?.commonChart() as? ChartData
            sumText.text =  "Expense sum: \(FinanceStrategyService.strategy?.sum() ?? 0) \(UserDataManager.data.currency!)"
        }
        else{
            sumText.text = ""
        }
        if typeSegment.selectedSegmentIndex == 0{
            statisticsText.text = FinanceStrategyService.strategy?.statistics()
        }else if typeSegment.selectedSegmentIndex == 1{
            statisticsText.text = FinanceStrategyService.strategy?.detailedStatistics()
        }else if typeSegment.selectedSegmentIndex == 2{
            statisticsText.text = FinanceStrategyService.strategy?.tips()
        }
        chartView.data = FinanceStrategyService.strategy?.commonChart() as? ChartData
    }
}
