//
//  LoginViewController.swift
//  PV239 project
//
//  Created by Jan Crha on 11/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseUI

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkLoggedIn()
    }
    
    private func checkLoggedIn() {
        Auth.auth().addStateDidChangeListener {auth, user in
            if user != nil {
                self.getTransactionsForUser(userId: user!.uid)
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Tabs", bundle: nil)
                let tabsViewController = storyBoard.instantiateInitialViewController() as! AnimatedUITabBarController
                self.present(tabsViewController, animated: true, completion: nil)
            } else {
                // No user is signed in.
                self.login()
            }
        }
    }
    
    private func login() {
        let authUI = FUIAuth.defaultAuthUI()
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: false, completion: nil)
    }

    private func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if error != nil {
            // handle errors
            return
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
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
