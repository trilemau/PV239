//
//  AddTransactionTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 04/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController {

    @IBOutlet weak var transactionTypeField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addTransactionButtonClicked(_ sender: UIBarButtonItem) {
        print(transactionTypeField.text!)
        print(categoryField.text!)
        print(amountField.text!)
        print(dateField.text!)
        
//        if let controller: TransactionDetailTableViewController = segue.destination as? TransactionDetailTableViewController {
//            if let index = tableView.indexPathForSelectedRow?.row {
//                controller.transaction = transactions[index]
//            }
//        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: TransactionsTableViewController = segue.destination as? TransactionsTableViewController {
            controller.transactions = TransactionsManager.shared.addTransactions(transactionsToAdd: [
                Transaction(id: "111", transactionType: TransactionType.Expense, category: Category.Clothes, amount: 20, date: Date(timeIntervalSinceNow: 0))])
        }
    }
}
