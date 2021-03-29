//
//  ViewController.swift
//  RestGuide
//
//  Created by Tech on 2021-03-28.
//  Copyright © 2021 gbc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.restName.text = restaurants[indexPath.row]["name"]
        cell.restDesc.text = restaurants[indexPath.row]["desc"]
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
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
    }
    


}

