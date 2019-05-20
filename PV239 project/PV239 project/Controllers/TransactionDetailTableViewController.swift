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
    var transactionType: TransactionType?
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionType = transaction?.transactionType
        category = transaction?.category
        
        transactionImage.image = transactionType?.image
        categoryImage.image = category?.image
        
        transactionTypeField.text = transaction?.transactionType?.description
        categoryField.text = transaction?.category?.description
        amountField.text = transaction?.amount?.description
        datePicker.date = transaction!.date!
        
        self.hideKeyboardWhenTappedAround()
        amountField.delegate = self
        
        datePicker.maximumDate = Date(timeIntervalSinceNow: 0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    func CheckAttributes() -> Bool {
        if (amountField.text?.count == 0) {
            CreateAlert(message: "Amount was not entered", controller: self)
            return false
        }
        
        return true
    }

    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        if (!CheckAttributes()) {
            return
        }
        
        transaction?.transactionType = transactionType
        transaction?.category = category
        transaction?.amount = Int(amountField.text!)!
        transaction?.date = datePicker.date
        
        TransactionsManager.shared.updatetransaction(transaction: transaction)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteTransactionButtonClicked(_ sender: UIButton) {
        let popup = UIAlertController(title: "Delete transaction", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        popup.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            self.controller?.transactions.remove(at: self.row!)
            TransactionsManager.shared.removeTransaction(transactionId: self.transaction?.id)
            
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
