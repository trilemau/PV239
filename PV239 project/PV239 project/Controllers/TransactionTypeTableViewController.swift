//
//  TransactionTypeTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 18/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class TransactionTypeTableViewController: UITableViewController {

    var addController: AddTransactionTableViewController?
    var editController: TransactionDetailTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: addController?.transactionType = TransactionType.Income
        case 1: addController?.transactionType = TransactionType.Expense
        default:
            addController?.transactionType = TransactionType.None
        }
        
        switch indexPath.row {
        case 0: editController?.transactionType = TransactionType.Income
        case 1: editController?.transactionType = TransactionType.Expense
        default:
            editController?.transactionType = TransactionType.None
        }
        
        addController?.ReloadImages()
        addController?.transactionTypeField.text = addController?.transactionType.description
            
        editController?.ReloadImages()
        editController?.transactionTypeField.text = editController?.transactionType.description
        
        navigationController?.popViewController(animated: true)
    }
}
