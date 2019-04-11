//
//  TransactionType.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 07/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation

enum TransactionType {
    case Income
    case Expense
    
    var description: String {
        switch self {
        case .Expense: return "Expense"
        case .Income: return "Income"
        }
    }
}
