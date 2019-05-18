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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionTypeField.isUserInteractionEnabled = false
        categoryField.isUserInteractionEnabled = false
        
        self.hideKeyboardWhenTappedAround()
        amountField.delegate = self
        
        datePicker.maximumDate = Date(timeIntervalSinceNow: 0)
        
        ReloadImages()
    }
    
    func ReloadImages() {
        transactionImage.image = transactionType.image
        categoryImage.image = category.image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }

    @IBAction func addTransactionButtonClicked(_ sender: UIBarButtonItem) {
        let id = UUID().uuidString
        let transactionType = TransactionType.Expense
        let category = Category.Entertainment
        let amount = Double(amountField.text!)!
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
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
