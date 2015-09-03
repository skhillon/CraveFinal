//
//  Storyboard.swift
//  Crave App
//
//  Created by Sarthak Khillon on 7/25/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

// FIX: What's going on here? Doesn't seem to be being used.

class Storyboard: UIStoryboard { //necessary for Storyboard creation -- FIX: again, what??
    class func create(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(name) as! UIViewController
    }
}