//
//  AddMealViewController.swift
//  AuthApp2
//
//  Created by Fernando Gonzalez on 10/13/21.
//

import UIKit
import AlamofireImage

class AddMealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //
    @IBOutlet weak var mealTitleTextField: UITextField!
    
    @IBOutlet weak var mealImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //Actions
    
    @IBAction func cancelTapped(_ sender: Any) {
        print("Cancel Tapped")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMealTapped(_ sender: Any) {
        
        print("Picture Added")
        
        
        let myUrl = URL(string: "http://127.0.0.1:8000/api/meal/create/")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
//
        // Validating text fields
        if (mealTitleTextField.text?.isEmpty)!
            
        
        
        {
        //
        let myUrl = URL(string: "http://127.0.0.1:8000/api/meal/create/")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        }
        //
        let postString = [
            "meal_name": mealTitleTextField.text!,
            "user": "1",
          
        ] as [String: String]
        
        //converting
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
          
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            //
            
            //if any errors
            if error != nil {
               
                print("error=\(String(describing:error))")
            }
            
            
            //convert response sent from server to a Dictionary
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as?NSDictionary
                //
                if let parseJSON = json {
                    //
                    print(parseJSON)
                    
                    let mealName = parseJSON["meal_name"] as? String
                    let userName = parseJSON["user"] as? String
                    print("Meal Name: \(String(describing: mealName))")
                    print("User Name: \(String(describing: userName))")
                    
                    
                    if (mealName?.isEmpty)!
                    {
                        //
                        print("Could not successfully perform this resquest. Please try again later")
                        return
                    }else{
                        print("Meal was added Successfully! ")
                        // Success
                       
        
                          
                        
                        //if everything is ok we take the user to the authenticated page
                        
                        DispatchQueue.main.async {
                            let loginBtnViewController =
                            self.storyboard?.instantiateViewController(withIdentifier: "RecepiesViewController") as! RecepiesViewController
                            
                            self.present(loginBtnViewController, animated: true)
                              }
                        
                        
                        
                    
                            
                            //print("Im in the feed 2")
                        

                    }
 
                    //
                }else {
                    //
                    print("Could not successfully perform this resquest. Please try again later")
                }
                
                
            ///end
            } catch {
                
                //
                print( "Could not successfully perform this resquest. Please try again later")
                print(error)
            }
        
        }
        task.resume()
        
        
        
    //END addMealTapped
    }
    
    
    //
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        //
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        //
        present(picker, animated: true, completion: nil)
        
    }
    
    //Function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        //resize it with alamofireimage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        mealImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
