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
    
    
    @IBAction func logoutButtonClicked(_ sender: UIButton) {
        let popup = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        popup.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            let authUI = FUIAuth.defaultAuthUI()
            
            do {
                try authUI?.signOut()
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyBoard.instantiateInitialViewController() as! UINavigationController
                self.present(loginViewController, animated: true, completion: nil)
            }
            catch {
                print("Error in logout: \(error)")
            }
            popup.dismiss(animated: true, completion: nil)
        }))
        
        popup.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            popup.dismiss(animated: true, completion: nil)
        }))
        
        self.present(popup, animated: true, completion: nil)
    }

}
