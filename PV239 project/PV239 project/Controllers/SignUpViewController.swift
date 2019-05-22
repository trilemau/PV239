//
//  SignUpViewController.swift
//  PV239 project
//
//  Created by Jan Crha on 21/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backToLoginButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        self.errorMessageLabel.text! = ""
        
        if !isValidEmail(testStr: self.emailTextField.text!) {
            self.errorMessageLabel.text! = "Invalid Email!"
        }
        else if self.passwordTextField.text!.count < 6 {
            self.errorMessageLabel.text! = "Password must be at least 6 characters long!"
        }
        else if self.passwordConfirmTextField.text! != self.passwordTextField.text! {
            self.errorMessageLabel.text! = "Passwords don't match!"
        }
        else {
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordConfirmTextField.text!) { authResult, error in
                if error != nil {
                    self.errorMessageLabel.text! = "Error while signing up!"
                }
            }
        }
        return
    }
}
