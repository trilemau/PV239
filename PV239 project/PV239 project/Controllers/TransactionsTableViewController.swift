//
//  TransactionsTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 06/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class TransactionsTableViewController: UITableViewController {
    
    var transactions: [Transaction] = []
    var addedTransaction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.transactions = TransactionsManager.shared.getTransactions()
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        self.tableView.endUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (addedTransaction)
        {
            self.transactions = TransactionsManager.shared.getTransactions()
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            self.tableView.endUpdates()
            
            self.tableView.reloadData()
            
            addedTransaction = false
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionIdentifier", for: indexPath) as! TransactionTableViewCell

        let transaction = transactions[indexPath.row]
        
        cell.categoryLabel.text = transaction.category?.description
        cell.amountLabel.text = transaction.amount?.description
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: TransactionDetailTableViewController = segue.destination as? TransactionDetailTableViewController {
            if let index = tableView.indexPathForSelectedRow?.row {
                controller.transaction = transactions[index]
            }
        }
        
        if let controller: AddTransactionTableViewController = segue.destination as? AddTransactionTableViewController {
            controller.controller = self
        }
    }
}
