//
//  AddTransactionTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 04/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var transactionImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var transactionTypeField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var transactionType: TransactionType = TransactionType.None
    var category: Category = Category.None
    var controller: TransactionsTableViewController?
    var categorySelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        amountField.delegate = self
        
        datePicker.maximumDate = Date()
        
        transactionImage.image = transactionType.image
        categoryImage.image = category.image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    func CheckAttributes() -> Bool {
        if (transactionType == TransactionType.None) {
            CreateAlert(message: "Transaction type was not selected", controller: self)
            return false
        }
        
        if (!categorySelected) {
            CreateAlert(message: "Category was not selected", controller: self)
            return false
        }
        
        if (amountField.text?.count == 0) {
            CreateAlert(message: "Amount was not entered", controller: self)
            return false
        }
        
        return true
    }

    @IBAction func addTransactionButtonClicked(_ sender: UIBarButtonItem) {
        if (!CheckAttributes()) {
            return
        }
        
        let id = UUID().uuidString
        let amount = Int(amountField.text!)!
        let date = datePicker.date
        
        controller?.transactions = TransactionsManager.shared.addTransactions(transactionsToAdd: [
            Transaction(id: id, transactionType: transactionType, category: category, amount: amount, date: date)])
        
        controller?.addedTransaction = true
        
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: TransactionTypeTableViewController = segue.destination as? TransactionTypeTableViewController {
            controller.addController = self
        }
        
        if let controller: CategoriesTableViewController = segue.destination as? CategoriesTableViewController {
            controller.addController = self
        }
    }
}
