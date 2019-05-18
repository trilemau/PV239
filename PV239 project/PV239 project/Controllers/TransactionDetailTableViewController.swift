//
//  TransactionDetailTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 05/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class TransactionDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var transactionImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var transactionTypeField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var controller: TransactionsTableViewController?
    var transaction: Transaction?
    var row: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionTypeField.text = transaction?.transactionType?.description
        categoryField.text = transaction?.category?.description
        amountField.text = transaction?.amount?.description
        datePicker.date = transaction!.date!
        
        transactionTypeField.isUserInteractionEnabled = false
        categoryField.isUserInteractionEnabled = false
        
        self.hideKeyboardWhenTappedAround()
        amountField.delegate = self
        
        datePicker.maximumDate = Date(timeIntervalSinceNow: 0)
        
        transactionImage.image = transaction?.transactionType?.image
        categoryImage.image = transaction?.category?.image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }

    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        // TODO: check transaction attributes
        
        transaction?.amount = Double(amountField.text!)!
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteTransactionButtonClicked(_ sender: UIButton) {
        let popup = UIAlertController(title: "Delete transaction", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        popup.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            self.controller?.transactions.remove(at: self.row!)
            
            self.navigationController?.popToRootViewController(animated: true)
            popup.dismiss(animated: true, completion: nil)
        }))
        
        popup.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            popup.dismiss(animated: true, completion: nil)
        }))
        
        self.present(popup, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: TransactionTypeTableViewController = segue.destination as? TransactionTypeTableViewController {
            controller.editController = self
        }
        
        if let controller: CategoriesTableViewController = segue.destination as? CategoriesTableViewController {
            controller.editController = self
        }
    }
}
