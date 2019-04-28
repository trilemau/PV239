//
//  TransactionsManager.swift
//  PV239 project
//
//  Created by Jan Crha on 28/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation

class TransactionsManager {
    public static let shared = TransactionsManager()
    
    private var transactions: [Transaction]
    
    private init() {
        self.transactions = []
    }
    
    public func getTransactions() -> [Transaction] {
        return self.transactions
    }
    
    public func setTransactions(transactions: [Transaction]) -> Void {
        self.transactions = transactions
    }
    
    public func addTransactions(transactionsToAdd: [Transaction], indexToInsertAfter: Int? = nil) -> [Transaction] {
        if indexToInsertAfter != nil {
            self.transactions.insert(contentsOf: transactionsToAdd, at: indexToInsertAfter!)
        }
        else {
            self.transactions.append(contentsOf: transactionsToAdd)
        }
        return self.transactions
    }
    
    public func removeTransaction(transactionId: String) -> [Transaction] {
        self.transactions = self.transactions.filter { $0.id != transactionId }
        return self.transactions
    }
}
