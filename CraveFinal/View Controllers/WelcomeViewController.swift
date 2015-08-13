//
//  WelcomeViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 8/7/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "Welcome to Crave!"
        self.instructionsLabel.text = "On the next screen, select the types of food you like the most."
        self.beginButton.setTitle("Let's get started", forState: .Normal)
        self.beginButton.tintColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
