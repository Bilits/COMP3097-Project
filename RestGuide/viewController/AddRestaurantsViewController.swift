//
//  AddRestaurantsViewController.swift
//  RestGuide
//
//  Created by Hossein Hajibaba-ali on 4/10/21.
//  Copyright ©️ 2021 gbc. All rights reserved.
//

import UIKit

class AddRestaurantsViewController: UIViewController {

    var db:DBHelper = DBHelper()
    var rate : Float = 3.0
    @IBOutlet var nameRestaurant:UITextField!
    @IBOutlet var descriptionRestaurant: UITextField!
    @IBOutlet var addressRestaurant: UITextField!
    @IBOutlet var phoneNumberRestaurant: UITextField!
    @IBOutlet var tagsRestaurant: UITextField!
    @IBOutlet var star: CosmosView!
    @IBAction func addRestaurant(_ sender: Any) {
        if nameRestaurant.text == "" || descriptionRestaurant.text == "" || addressRestaurant.text == "" || phoneNumberRestaurant.text == "" || tagsRestaurant.text == "" {
            showToast(message: "fill all textField")
        }else{
            db.insert(nameRestaurant: nameRestaurant.text!, descriptionRestaurant: descriptionRestaurant.text!, addressRestaurant: addressRestaurant.text!, phoneNumberRestaurant: phoneNumberRestaurant.text!, tagsRestaurant: tagsRestaurant.text!,rate: String(self.rate) )
            showToastGreen(message: "Successfully inserted")
        }
       
    }
    @IBAction func cancelAdd(_ sender: Any) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}