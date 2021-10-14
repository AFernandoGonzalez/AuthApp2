//
//  FeedViewController.swift
//  AuthApp2
//
//  Created by Fernando Gonzalez on 10/10/21.
//

import UIKit

import SwiftKeychainWrapper

class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    //LOGOUT
    @IBAction func signoutButtonTapped(_ sender: Any) {
        print("Signout Button Tapped")
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        KeychainWrapper.standard.removeObject(forKey: "userID")
        
       
        
        
        //self.performSegue(withIdentifier: "loginSegue", sender: nil)
        
        let loginViewController =
        self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.present(loginViewController, animated: true)
    }
    
    
    //PROFILE
    @IBAction func profileButtonTapped(_ sender: Any) {
        print("Profile Button Tapped")
    }
    
    
    
    
    
 //END FeedViewController
}
