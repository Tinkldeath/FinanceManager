//
//  PPublisher.swift
//  FinanceManager
//
//  Created by Dima on 4.06.22.
//

import Foundation

protocol PPublisher: AnyObject{
    var subscribers: [PSubscriber] { get }
    
    func subscribe(_ subscriber: PSubscriber)
    func unsubscribe(_ subscriber: PSubscriber)
    func notify()
}
