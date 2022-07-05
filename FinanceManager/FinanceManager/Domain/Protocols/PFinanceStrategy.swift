//
//  PFinanceStrategy.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import Foundation

protocol PFinanceStrategy{
    
    var options: SChartSettings? { get }
    
    func statistics() -> String
    func detailedStatistics() -> String
    func tips() -> String
    
    func commonChart() -> Any
    func setOptions(_ options: SChartSettings?)
    
    func sum() -> Double
}
