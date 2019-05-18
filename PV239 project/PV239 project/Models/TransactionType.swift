//
//  TransactionType.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 07/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation
import UIKit

enum TransactionType {
    case Income
    case Expense
    case None
    
    var description: String {
        switch self {
            case .Expense: return "Expense"
            case .Income: return "Income"
            case .None: return "None"
        }
    }
    
    var image: UIImage {
        switch self {
            case .Income: return #imageLiteral(resourceName: "IncomeIcon")
            case .Expense: return #imageLiteral(resourceName: "ExpenseIcon")
            case .None: return #imageLiteral(resourceName: "NoneIcon")
        }
    }
}
