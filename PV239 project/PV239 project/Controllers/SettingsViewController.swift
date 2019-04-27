//
//  SettingsViewController.swift
//  PV239 project
//
//  Created by Jan Crha on 27/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        
        do {
            try authUI?.signOut()
            print("LOGOUT")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyBoard.instantiateInitialViewController() as! LoginViewController
            self.present(loginViewController, animated: true, completion: nil)
        }
        catch {
            print("Error in logout: \(error)")
        }
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
