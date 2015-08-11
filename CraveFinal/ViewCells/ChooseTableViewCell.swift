//
//  ChooseTableViewCell.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/15/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class ChooseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealLabel: UILabel! {
        didSet {
            if let lbl = mealLabelHolder {
                mealLabel.text = lbl
            }
        }
    }
    
    var mealLabelHolder: String! {
        didSet {
            if mealLabel != nil && mealLabelHolder != nil{
                mealLabel.text = mealLabelHolder
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
