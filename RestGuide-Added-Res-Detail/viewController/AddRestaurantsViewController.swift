//
//  ViewController.swift
//  RestGuide
//
//  Created by Tech on 2021-03-28.
//  Copyright © 2021 gbc. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedRestaurant: Restaurant!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.restName.text = listRestaurants[indexPath.row].nameRestaurant
        cell.restDesc.text = listRestaurants[indexPath.row].descriptionRestaurant
        cell.star.rating = Double(listRestaurants[indexPath.row].rate)! 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = listRestaurants[indexPath.row]
        self.performSegue(withIdentifier: "restaurantDetailsSegue", sender: self)
    }
    

    @IBOutlet weak var tableView: UITableView!
    var db:DBHelper = DBHelper()

    let restaurants = [
        ["name":"KFC", "desc":"KFC Desc"],
        ["name":"McDonald","desc":"McDonald Desc"],
        ["name":"Nandos","desc":"Nandos Desc"],
        ["name":"Harveys","desc":"Harveys Desc"],
        ["name":"Hero Burger","desc":"Hero Burger Desc"]
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        listRestaurants = db.read()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        listRestaurants = db.read()
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantDetailsSegue" {
            if segue.destination is RestaurantDetailViewController {
                (segue.destination as! RestaurantDetailViewController).restaurant = selectedRestaurant
            }
        }
    }


}

