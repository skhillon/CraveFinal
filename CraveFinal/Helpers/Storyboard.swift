//
//  Storyboard.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/25/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class Storyboard: UIStoryboard { //necessary for Storyboard creation
    class func create(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(name) as! UIViewController
    }
}