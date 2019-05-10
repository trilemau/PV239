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
        
        self.transactions = TransactionsManager.shared.getTransactions()
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        self.tableView.endUpdates()
        
        for t in transactions {
            print("amount", t.amount)
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let controller: TransactionDetailTableViewController = segue.destination as? TransactionDetailTableViewController {
            if let index = tableView.indexPathForSelectedRow?.row {
                controller.transaction = transactions[index]
            }
        }
    }

    @IBAction func onButtonClicked(_ sender: Any) {
        print("button")
        self.transactions = TransactionsManager.shared.addTransactions(transactionsToAdd: [
            Transaction(id: "111", transactionType: TransactionType.Expense, category: Category.Clothes, amount: 40, date: Date(timeIntervalSinceNow: 0))])
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
}
