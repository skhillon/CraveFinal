//
//  DataViewController.swift
//  PageBased
//
//  Created by Sarthak Khillon on 8/31/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataObject: AnyObject?
    //var iconImage: UIImage?
    var detailText: String?
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent // FIX: this is fine, but you know you can set this in Storyboard right?
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            self.dataLabel!.text = obj.description
            //self.imageView.image = iconImage
            self.detailsLabel.text = detailText
            self.pageControl.currentPage = pageIndex!
        } else {
            self.dataLabel!.text = ""
        }
    }
    
    
}

