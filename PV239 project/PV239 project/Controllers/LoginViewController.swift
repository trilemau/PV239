//
//  LoginNewViewController.swift
//  PV239 project
//
//  Created by Jan Crha on 21/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        checkLoggedIn()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func checkLoggedIn() {
        Auth.auth().addStateDidChangeListener {auth, user in
            if user != nil {
                self.getTransactionsForUser(userId: user!.uid)
            } else {
                // No user is signed in.
                return
            }
        }
    }
    
    private func getTransactionsForUser(userId: String) {
        let db = Firestore.firestore()
        db.collection("transactions").whereField("user_id", isEqualTo: userId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                var transactions: [Transaction] = []
                
                for document in querySnapshot!.documents {
                    let transaction: Transaction = Transaction()
                    for record in document.data() {
                        switch record.key {
                        case "id":
                            transaction.id = record.value as? String
                        case "transactionType":
                            transaction.setTransactionType(transactionTypeName: record.value as? String ?? "unknown")
                        case "category":
                            transaction.setCategory(categoryName: record.value as? String ?? "unknown")
                        case "amount":
                            transaction.amount = record.value as? Int
                        case "date":
                            transaction.date = record.value as? Date
                        default:
                            break
                        }
                    }
                    transactions.append(transaction)
                }
                TransactionsManager.shared.setTransactions(transactions: transactions)
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
                let tabsViewController = storyBoard.instantiateInitialViewController() as! AnimatedUITabBarController
                self.present(tabsViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.errorMessage.text = ""
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        self.errorMessage.text = ""
        
        if !isValidEmail(testStr: self.emailTextField.text!) {
            self.errorMessage.text! = "Invalid Email!"
        }
        else if self.passwordTextField.text!.count < 6 {
            self.errorMessage.text! = "Password must be at least 6 characters long!"
        }
        else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { [weak self] user, error in
                guard self != nil else { return }
                if let error = error {
                    print("Error while logging in: \(error)")
                    self!.errorMessage.text = "Error while logging in!"
                }
            }
        }
        
        return
    }
}
