//
//  AddRestaurantsViewController.swift
//  RestGuide
//
//  Created by Hossein Hajibaba-ali on 4/10/21.
//  Copyright ©️ 2021 gbc. All rights reserved.
//

import UIKit

class AddRestaurantsViewController: UIViewController {

    var isInEditMode: Bool = false
    var restaurant: Restaurant!
    var db:DBHelper = DBHelper()
    var rate : Float = 3.0
    @IBOutlet var nameRestaurant:UITextField!
    @IBOutlet var descriptionRestaurant: UITextField!
    @IBOutlet var addressRestaurant: UITextField!
    @IBOutlet var phoneNumberRestaurant: UITextField!
    @IBOutlet var tagsRestaurant: UITextField!
    @IBOutlet var star: CosmosView!
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func addRestaurant(_ sender: Any) {
        if nameRestaurant.text == "" || descriptionRestaurant.text == "" || addressRestaurant.text == "" || phoneNumberRestaurant.text == "" || tagsRestaurant.text == "" {
            showToast(message: "fill all textField")
        } else{
            if isInEditMode {
                db.update(id: restaurant.id, newValue: Restaurant(id: restaurant.id, nameRestaurant: nameRestaurant.text!, descriptionRestaurant: descriptionRestaurant.text!, addressRestaurant: addressRestaurant.text!, phoneNumberRestaurant: phoneNumberRestaurant.text!, tagsRestaurant: tagsRestaurant.text!, rate: String(self.rate)))
                showToastGreen(message: "Successfully updated.")
            } else  {
                db.insert(nameRestaurant: nameRestaurant.text!, descriptionRestaurant: descriptionRestaurant.text!, addressRestaurant: addressRestaurant.text!, phoneNumberRestaurant: phoneNumberRestaurant.text!, tagsRestaurant: tagsRestaurant.text!,rate: String(self.rate) )
                showToastGreen(message: "Successfully inserted")
                blankAllTextFields()
            }
        }
       
    }
    @IBAction func cancelAdd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = db.read()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
        star.rating = Double(self.rate)
        star.didTouchCosmos = didTouchCosmos
        star.didFinishTouchingCosmos = didFinishTouchingCosmos
        // Do any additional setup after loading the view.
        
        if isInEditMode {
            listRestaurants = db.read()
            restaurant = listRestaurants.filter { (restarurant) in
                restaurant.id == self.restaurant.id
            }.first
            setupEditMode()
        }
    }
    
    private func setupEditMode() {
        if isInEditMode {
            titleLabel.isHidden = true
            self.title = "Edit Restaurant"
            fillViews()
            addEditButton.setTitle("Save", for: .normal)
        }
    }
    
    private func fillViews() {
        nameRestaurant.text = restaurant.nameRestaurant
        descriptionRestaurant.text = restaurant.descriptionRestaurant
        addressRestaurant.text = restaurant.addressRestaurant
        phoneNumberRestaurant.text = restaurant.phoneNumberRestaurant
        tagsRestaurant.text = restaurant.tagsRestaurant
        star.rating = Double(restaurant.rate) ?? 0
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    private func didTouchCosmos(_ rating: Double) {

        self.rate = Float(rating)
        print(rate)
      
     }
    private func didFinishTouchingCosmos(_ rating: Double) {
        print(rate)
        self.rate = Float(rating)
     
    }

    private func blankAllTextFields() {
        nameRestaurant.text = ""
        descriptionRestaurant.text = ""
        addressRestaurant.text = ""
        phoneNumberRestaurant.text = ""
        tagsRestaurant.text = ""
    }


}
