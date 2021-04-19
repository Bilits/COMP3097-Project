//
//  RoundBackButton.swift
//  RestGuide
//
//  Created by Saeed Reza Tavallaee on 4/16/21.
//  Copyright © 2021 gbc. All rights reserved.
//

import UIKit

@IBDesignable
class RoundBackButton: UIButton {


    @IBInspectable public var backColor: UIColor = .white { didSet { updateBackgroundColor() } }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        updateBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateBackgroundColor()
    }
    
}
private extension RoundBackButton {
    func updateBackgroundColor() {
        self.layer.backgroundColor = backColor.cgColor
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}
