//
//  Transaction.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 06/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation

class Transaction {
    var transactionType: TransactionType
    var category: Category
    var amount: Double
    var date: Date
    
    init(transactionType: TransactionType, category: Category, amount: Double, date: Date) {
        self.transactionType = transactionType
        self.category = category
        self.amount = amount
        self.date = date
    }
    
    var description: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let output = "\(transactionType) - \(category): \(amount) (\(formatter.string(from: date)))"
        return output
    }
}
