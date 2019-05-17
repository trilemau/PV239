//
//  AddTransactionTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 04/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var transactionTypeField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    var controller: TransactionsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }

    @IBAction func addTransactionButtonClicked(_ sender: UIBarButtonItem) {
        print(transactionTypeField.text!)
        print(categoryField.text!)
        print(amountField.text!)
        print(dateField.text!)
        
        let id = UUID().uuidString
        let transactionType = TransactionType.Expense
        let category = Category.Entertainment
        let amount = Double(amountField.text!)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: dateField.text!)!
        
        controller?.transactions = TransactionsManager.shared.addTransactions(transactionsToAdd: [
            Transaction(id: id, transactionType: transactionType, category: category, amount: amount, date: date)])
        
        controller?.addedTransaction = true
        
        navigationController?.popViewController(animated: true)
    }
    
    //    @IBAction func addTransactionClicked(_ sender: UIButton) {
    //        return
    //
    //        guard let userId = Auth.auth().currentUser?.uid else { return }
    //
    //        let db = Firestore.firestore()
    //        let id = UUID().uuidString
    //
    //        self.transactions = TransactionsManager.shared.addTransactions(transactionsToAdd: [
    //            Transaction(id: id, transactionType: TransactionType.Expense, category: Category.EatingOut, amount: 500, date: Date())
    //            ])
    //        self.tableView.beginUpdates()
    //        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    //        self.tableView.endUpdates()
    //
    //        db.collection("transactions").addDocument(data: [
    //            "id": id,
    //            "transactionType": TransactionType.Expense.description,
    //            "category": Category.EatingOut.description,
    //            "amount": 500,
    //            "date": Date(),
    //            "user_id": userId
    //        ]) { err in
    //            if let err = err {
    //                print("Error adding document: \(err)")
    //            }
    //        }
    //    }
}
