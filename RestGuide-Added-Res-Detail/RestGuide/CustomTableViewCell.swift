//
//  CustomTableViewCell.swift
//  RestGuide
//
//  Created by Tech on 2021-03-28.
//  Copyright © 2021 gbc. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var restName: UILabel!
    
    @IBOutlet weak var restDesc: UILabel!
    
    @IBOutlet var star: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
