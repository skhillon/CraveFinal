//
//  WelcomeViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 8/7/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleLabel.text = "Welcome to Crave!"
        self.instructionsLabel.text = "On the next screen, select your 5 favorite food categories!"
        self.beginButton.setTitle("LET'S GO!", forState: .Normal)
        //self.beginButton.tintColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
