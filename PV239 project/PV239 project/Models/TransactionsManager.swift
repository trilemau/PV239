//
//  TransactionsManager.swift
//  PV239 project
//
//  Created by Jan Crha on 28/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

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
        self.addTransactionsToDatabase(transactionsToAdd: transactionsToAdd)
        
        return self.transactions
    }
    
    public func removeTransaction(transactionId: String?) -> [Transaction]? {
        if transactionId == nil {
            return nil
        }
        self.transactions = self.transactions.filter { $0.id != transactionId }
        self.removeTransactionFromDatabase(transactionId: transactionId!)
        
        return self.transactions
    }
    
    public func updatetransaction(transaction: Transaction?) -> Void {
        if transaction == nil {
            return
        }
        let indexOfTransaction = self.transactions.index(where: { $0.id == transaction!.id })
        if indexOfTransaction != nil {
            self.transactions[indexOfTransaction!] = transaction!
            self.updateTransactionInDatabase(transaction: transaction!)
        }
    }
    
    private func addTransactionsToDatabase(transactionsToAdd: [Transaction]) -> Void {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        for transaction in transactionsToAdd {
            db.collection("transactions").addDocument(data: [
                "id": transaction.id as Any,
                "transactionType": transaction.transactionType?.description as Any,
                "category": transaction.category?.description as Any,
                "amount": transaction.amount as Any,
                "date": transaction.date as Any,
                "user_id": userId as Any,
                ]) { err in
                    if let err = err {
                        print("Error while adding document: \(err)")
                    }
            }
        }
    }
    
    private func removeTransactionFromDatabase(transactionId: String) -> Void {
        let db = Firestore.firestore()
        
        db.collection("transactions").whereField("id", isEqualTo: transactionId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting transactions: \(err)")
                return
            }
            for document in querySnapshot!.documents {
                db.collection("transactions").document(document.documentID).delete() { error in
                    if let error = error {
                        print("Error while deleting transaction: \(error, document.documentID)")
                    }
                }
            }
        }
    }
    
    private func updateTransactionInDatabase(transaction: Transaction) -> Void {
        let db = Firestore.firestore()
        
        db.collection("transactions").whereField("id", isEqualTo: transaction.id!).getDocuments() { querySnapshot, err in
            if let err = err {
                print("Error while getting transaction: \(err)")
                return
            }
            for document in querySnapshot!.documents {
                db.collection("transactions").document(document.documentID).updateData([
                    "transactionType": transaction.transactionType?.description as Any,
                    "category": transaction.category?.description as Any,
                    "amount": transaction.amount as Any,
                    "date": transaction.date as Any,
                ]) { error in
                    if let error = error {
                        print("Error while updating transaction: \(error, document.documentID)")
                    }
                }
            }
        }
    }
}
