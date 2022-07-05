//
//  FinanceStrategyManager.swift
//  FinanceManager
//
//  Created by Dima on 31.05.22.
//

import Foundation

class FinanceStrategyService{
    
    private init() {}
    
    static private(set) var strategy: PFinanceStrategy?
    
    static func setStrategy(_ strategy: PFinanceStrategy){
        self.strategy = strategy
    }
}
