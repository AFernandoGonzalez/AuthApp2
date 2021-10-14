//
//  DetailRecepieViewController.swift
//  AuthApp2
//
//  Created by Fernando Gonzalez on 10/13/21.
//

import UIKit
import AlamofireImage

class DetailRecepieViewController: UIViewController {
    
    
    @IBOutlet weak var mealBackdropView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    
    //
    var meal: [String:Any]!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(meal["meal_name"])
        
        mealTitleLabel.text = meal["meal_name"] as? String
        datePostedLabel.text = meal["updated_at"] as? String
        
        
        //Displaying image
        let baseUrl = "http://127.0.0.1:8000"
        let mealPath = meal["meal_photo"] as! String
        let mealUrl = URL(string: baseUrl + mealPath)
        
        mealBackdropView.af.setImage(withURL: mealUrl!)
        
    // END viewDidLoad
    }
    

    
//END DetailRecepieViewController
}
