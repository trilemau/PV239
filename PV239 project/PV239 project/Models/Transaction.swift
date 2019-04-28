//
//  Transaction.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 06/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation

class Transaction {
    var id: String?
    var transactionType: TransactionType?
    var category: Category?
    var amount: Double?
    var date: Date?
    
    init() {
        self.id = nil
        self.transactionType = nil
        self.category = nil
        self.amount = nil
        self.date = nil
    }
    
    init(id: String, transactionType: TransactionType, category: Category, amount: Double, date: Date) {
        self.id = id
        self.transactionType = transactionType
        self.category = category
        self.amount = amount
        self.date = date
    }
    
    func setCategory(categoryName: String) -> Void {
        switch categoryName {
            case Category.Clothes.description:
                self.category = Category.Clothes
            case Category.EatingOut.description:
                self.category = Category.EatingOut
            case Category.Entertainment.description:
                self.category = Category.Entertainment
            case Category.Fuel.description:
                self.category = Category.Fuel
            case Category.Kids.description:
                self.category = Category.Kids
            case Category.Shopping.description:
                self.category = Category.Shopping
            case Category.Sport.description:
                self.category = Category.Sport
            case Category.Travel.description:
                self.category = Category.Travel
            default:
                return
        }
    }
    
    func setTransactionType(transactionTypeName: String) -> Void {
        switch transactionTypeName {
            case TransactionType.Expense.description:
                self.transactionType = TransactionType.Expense
            case TransactionType.Income.description:
                self.transactionType = TransactionType.Income
            default:
                return
        }
    }
    
    var description: String {
        guard self.date != nil && self.transactionType != nil && category != nil && amount != nil else { return "Erroneous data" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let output = "\(transactionType!) - \(category!): \(amount!) (\(formatter.string(from: date!))"
        return output
    }
}
