//
//  Helpers.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 7/5/2023.
//

import Foundation

struct Helpers {
    static let numberFormatter: NumberFormatter = {
         let formatter = NumberFormatter()
         formatter.isLenient = false
        formatter.numberStyle = .currencyAccounting
        
         return formatter
     }()
}
