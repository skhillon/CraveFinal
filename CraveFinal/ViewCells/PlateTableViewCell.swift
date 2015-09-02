//
//  PlateTableViewCell.swift
//  Crave App
//
//  Created by Sarthak Khillon on 7/15/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class PlateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    @IBOutlet weak var restaurantLabel: UILabel! {
        didSet {
            if let lbl = restaurantLabelHolder {
                restaurantLabel.text = lbl
                restaurantLabel.lineBreakMode = NSLineBreakMode.ByClipping
            }
        }
    }
    
    var restaurantLabelHolder: String! {
        didSet {
            if restaurantLabel != nil && restaurantLabelHolder != nil{
                restaurantLabel.text = restaurantLabelHolder
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //mealTitleLabel.attributedText = attrString
      //  mealTitleLabel.lineBreakMode = NSLineBreakMode.ByClipping
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
