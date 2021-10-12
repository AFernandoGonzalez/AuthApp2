//
//  LoginViewController.swift
//  AuthApp2
//
//  Created by Fernando Gonzalez on 10/10/21.
//

import UIKit

import Alamofire
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //Returning User
//    override func viewDidAppear(_ animated: Bool) {
//        
//        //
//        let accessTokenn: String? = KeychainWrapper.standard.string(forKey: "accessToken")
//        
//        if accessTokenn != nil
//        {
//            
//            print("_________accessToken_________")
//            print(accessTokenn!)
//            print("_____________________________")
//            //
//            self.performSegue(withIdentifier: "myFeedSegue", sender: nil)
//        }
//    }

    
    
    
    @IBAction func onSignInButton(_ sender: Any) {
        
        print("Sign in Button Tapped")
        
        print("Sign in Button Tapped")
        
        //
        let email = emailTextField.text
        let password = passwordTextField.text
        
        // cheack if required fields are not empty
        if (email?.isEmpty)! || (password?.isEmpty)!
        {
            //Display alert message
            print("Email \(String(describing: email)) or passwod \(String(describing: password)) is empty")
            
            displayMessage(userMessage: "One of the required fields is missing!")
            
            return
        }
        
        
        //Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        myActivityIndicator.center = view.center
        
        //
        myActivityIndicator.hidesWhenStopped = false
        
        //start activity Indicator
        myActivityIndicator.startAnimating()
        
        //
        view.addSubview(myActivityIndicator)
        
        
        //
        let myUrl = URL(string: "http://127.0.0.1:8000/api/login/")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //
        let postString = [
            "email": email!,
            "password": password!,
        ] as [String: String]
        
        
        //converting
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
        }
        
        
        //
        
        let task = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
        //
        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
        //
            //if any errors
        if error != nil {
            self.displayMessage(userMessage: "Could not successfully reqest. Please Try again later")
                print("error=\(String(describing:error))")
                return
            }
            
            
            //convert response sent from server to a Dictionary
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as?NSDictionary
                
                
                
                //
                if let parseJSON = json {
                    
                    print(parseJSON)
                    //
                    let accessToken = parseJSON["token"] as? String
                    let userID = parseJSON["userID"] as? String
                    print("Access Token: \(String(describing: accessToken!))")
                    print("User Id: \(String(describing: userID!))")
                    
                    //you can store user id if you have one
                    //keychain
                    
                    let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                    let saveUserID: Bool = KeychainWrapper.standard.set(userID!, forKey: "userID")
                    
                    print("accessToken")
                    print("userID")
                    
                    //
   
                    print("The Access token result: \(saveAccessToken)")
                    print("The Access token result: \(saveUserID)")
                    
                    
                    if (accessToken?.isEmpty)!
                    {
                        //
                        self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                        return
                    }
                    
                    //if everything is ok we take the user to the authenticated page
                  
                    DispatchQueue.main.async {
                    let feedBtnViewController =
                    self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
                    
                    self.present(feedBtnViewController, animated: true)
                        
                        
                        //print("Im in the feed 2")
                    }
                    //print("Im in the feed 3")
                                
                    
                    
                    //
            }else {
                    //
                    self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                }
                
                
            ///end
            } catch {
                //
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                //
                self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                print(error)
            }
            
            
            
        }
        task.resume()
        
    
    
        //END onSignInButton
    }
    
    
    // function message
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            //
            let OKAction = UIAlertAction(title: "ok", style: .default)
            {
                (action:UIAlertAction!) in
                //
                print("Ok button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            //
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
        
    
    // Message Removal
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //END
}
