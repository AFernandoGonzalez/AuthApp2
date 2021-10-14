//
//  RecepiesViewController.swift
//  AuthApp2
//
//  Created by Fernando Gonzalez on 10/13/21.
//

import UIKit
import AlamofireImage

class RecepiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    //tableView
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    //Variable availble in the lifetime of the screen
    var meals = [[String:Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        
        // start calling api
        let url = URL(string: "http://127.0.0.1:8000/api/meals/")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data)
                 
                 self.meals = dataDictionary as! [[String:Any]]
                 
                 self.tableView.reloadData()
                 
                 
                 //download is complete : reload table view data
                 self.tableView.reloadData()
                 
                 print(dataDictionary)

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        
    // END viewDidLoad
    }
    
    
    // Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealsCell") as! MealsCell
        
        let meal = meals[indexPath.row]
        let title = meal["meal_name"] as! String
        let description = meal["updated_at"] as! String
        
        
        cell.recepieTitleLabel.text = title
        cell.recepieDescriptionLabel.text = description
        
        //Displaying image
        let baseUrl = "http://127.0.0.1:8000"
        let mealPath = meal["meal_photo"] as! String
        let mealUrl = URL(string: baseUrl + mealPath)
        
        cell.recepieImg.af.setImage(withURL: mealUrl!)
        
        
        
        return cell
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("Loading details")
        
        //find selcted meal
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let meal = meals[indexPath.row]
        
        
        //pas the selected meal to the details screen
        let detailsViewController = segue.destination as! DetailRecepieViewController
        detailsViewController.meal = meal
        
        //deselecting after click on individual meal
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    //Add recipe BTN
    
    @IBAction func addRecipeTapped(_ sender: Any) {
        print("Added A New Recipe Btn Tapped")
        let loginViewController =
        self.storyboard?.instantiateViewController(withIdentifier: "AddMealViewController") as! AddMealViewController
        
        self.present(loginViewController, animated: true)
    }
    
    

  

    
    //ENDRecepiesViewController
}
