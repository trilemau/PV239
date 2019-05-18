//
//  TransactionDetailTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 05/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class TransactionDetailTableViewController: UITableViewController {

    var transaction: Transaction?
    
    @IBOutlet weak var transactionTypeField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    var transactionType: TransactionType = TransactionType.None
    var category: Category = Category.None
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionTypeField.text = transaction?.transactionType?.description
        categoryField.text = transaction?.category?.description
        amountField.text = transaction?.amount?.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: (transaction?.date!)!)
    }
    
    func ReloadImages() {
        // TODO:
    }

    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        print("Save button clicked")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteTransactionButtonClicked(_ sender: UIButton) {
        let popup = UIAlertController(title: "Delete transaction", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        popup.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
            popup.dismiss(animated: true, completion: nil)
        }))
        
        popup.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
            popup.dismiss(animated: true, completion: nil)
        }))
        
        self.present(popup, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: TransactionTypeTableViewController = segue.destination as? TransactionTypeTableViewController {
            controller.editController = self
        }
    }
}
