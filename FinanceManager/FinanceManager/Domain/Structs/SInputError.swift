//
//  SInputError.swift
//  FinanceManager
//
//  Created by Dima on 1.06.22.
//

import Foundation

struct SInputError: Error{
    var localizedDescription: String
    var field: String
}
