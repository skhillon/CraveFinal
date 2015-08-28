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
        
        self.titleLabel.text = "Welcome to Crave!"
        self.instructionsLabel.text = "Crave allows you to find meals that you like and the restaurants that offer them."
        self.beginButton.setTitle("LET'S GO!", forState: .Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

        //self.beginButton.tintColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
