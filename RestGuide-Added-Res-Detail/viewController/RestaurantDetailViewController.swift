//
//  RestaurantDetailViewController.swift
//  RestGuide
//
//  Created by Saeed Reza Tavallaee on 4/16/21.
//  Copyright © 2021 gbc. All rights reserved.
//

import UIKit
import TagListView
import MessageUI

class RestaurantDetailViewController: UIViewController {
    
    var restaurant: Restaurant!
    var db:DBHelper = DBHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        fillRestaurantDetails()
        fillTagView()
        
        shareOnFacebookButton.addRightIcon(image: #imageLiteral(resourceName: "facebook"))
        shareOnTwitterButton.addRightIcon(image: #imageLiteral(resourceName: "twitter"))
        shareWithEmailButton.addRightIcon(image: #imageLiteral(resourceName: "email"))
        openMapButton.addRightIcon(image: #imageLiteral(resourceName: "location_pin"))
        openDirectionButton.addRightIcon(image: #imageLiteral(resourceName: "direction"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listRestaurants = db.read()
        restaurant = listRestaurants.filter { (restarurant) in
            restaurant.id == self.restaurant.id
        }.first
        fillRestaurantDetails()
        fillTagView()
    }
    
    private func fillRestaurantDetails() {
        titleLabel.text = restaurant.nameRestaurant
        ratingBar.rating = Double(restaurant.rate) ?? 0
        addressLabel.text = "Address: \(restaurant.addressRestaurant)"
        phoneLabel.text = "Phone: \(restaurant.phoneNumberRestaurant)"
        descriptionLabel.text = "Description: \(restaurant.descriptionRestaurant)"
    }
    
    private func fillTagView() {
        let splittedTags = restaurant.tagsRestaurant.split(separator: " ")
        tagListView.removeAllTags()
        splittedTags.forEach { (tag) in
            tagListView.addTag(String(tag))
        }
        tagListView.textFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddRestaurantsViewController {
            let viewController = (segue.destination as! AddRestaurantsViewController)
            viewController.isInEditMode = true
            viewController.restaurant = restaurant
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var shareOnFacebookButton: RoundBackButton!
    @IBOutlet weak var shareOnTwitterButton: RoundBackButton!
    @IBOutlet weak var shareWithEmailButton: RoundBackButton!
    @IBOutlet weak var openMapButton: RoundBackButton!
    @IBOutlet weak var openDirectionButton: RoundBackButton!
    
    // MARK: IBActions
    @IBAction func returnToRestaurants(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func modifyContent(_ sender: Any) {
        performSegue(withIdentifier: "editRestaurantSegue", sender: self)
    }
    
    @IBAction func shareOnFacebook(_ sender: Any) {
        shareText(text: "\(restaurant.nameRestaurant) \n\(restaurant.addressRestaurant)")
    }
    
    @IBAction func shareOnTwitter(_ sender: Any) {
        let shareText = "\(restaurant.nameRestaurant) \n\(restaurant.addressRestaurant)"
        let shareString = "https://twitter.com/intent/tweet?text=\(shareText)"

        // encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        // cast to an url
        let url = URL(string: escapedShareString)

        // open in safari
        UIApplication.shared.open(url!)
    }
    
    @IBAction func shareWithEmail(_ sender: Any) {
        let shareText = "\(restaurant.nameRestaurant) \n\(restaurant.addressRestaurant)"
        
        if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.setMessageBody("<p>\(shareText)</p>", isHTML: true)

                present(mail, animated: true)
            } else {
                self.shareText(text: "\(restaurant.nameRestaurant) \n\(restaurant.addressRestaurant)")
            }
    }
    
    @IBAction func openLocationOnMap(_ sender: Any) {
        let urlString = "http://maps.apple.com/?q=\(restaurant.addressRestaurant.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        UIApplication.shared.open(URL(string: urlString)!)
    }
    
    @IBAction func directionToRestaurant(_ sender: Any) {
        let urlString = "http://maps.apple.com/?daddr=\(restaurant.addressRestaurant.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")&dirflg=d&t=h"
        UIApplication.shared.open(URL(string: urlString)!)
    }
    
    private func shareText(text: String) {
            let shareAll = [text]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
}

extension UIButton {
    func addRightIcon(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        let length = CGFloat(15)
        titleEdgeInsets.right += length

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: length),
            imageView.heightAnchor.constraint(equalToConstant: length)
        ])
    }
}
