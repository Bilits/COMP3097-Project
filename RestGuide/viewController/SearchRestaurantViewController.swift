//
//  SearchRestaurantViewController.swift
//  RestGuide
//
//  Created by Hossein Hajibaba-ali on 4/11/21.
//  Copyright ©️ 2021 gbc. All rights reserved.
//

import UIKit

class SearchRestaurantViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! CustomTableViewCell
        cell.restName.text = Restaurants[indexPath.row].nameRestaurant
        cell.restDesc.text = Restaurants[indexPath.row].descriptionRestaurant
        cell.star.rating = Double(Restaurants[indexPath.row].rate)!
        return cell
    }
    
    var searchText = ""
    var db:DBHelper = DBHelper()
    var Restaurants : [Restaurant] = []
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.Restaurants = db.read()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Restaurants = db.read()
        tableview.reloadData()
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
extension SearchRestaurantViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //  searchQuestion = questions.filter({$0.text == searchText})
        self.searchText =  searchText
        if searchText.count >= 2
        {
           
            Restaurants = Restaurants.filter { $0.tagsRestaurant.localizedCaseInsensitiveContains(searchText) || $0.tagsRestaurant.contains(searchText)
            }
            
            tableview.reloadData()
                   
                  
                
                           
                     
        }else{
            Restaurants = listRestaurants
            tableview.reloadData()
        }
                       
                   
        

    }
   
}