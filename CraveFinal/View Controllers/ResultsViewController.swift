//
//  ResultsViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/31/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import MapKit

class ResultsViewController: UIViewController {
    
    // I need to get these values from the specific MealObject that is stored in the cell I clicked on. How?
    //indexpath.row, get that value, store it somewhere, and then prepareforsegue send it here.
    
    var mealObject: MealObject!
    // Currently hardcoded values.
    //wait this is already stored in mealObject wat r u doing y u make again
//    let longitudeOfVenue: Double!
//    let latitudeOfVenue: Double!
//    let nameOfVenue: String!
//    let mealPrice: String!
    
    
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var openMapsButton: UIButton!
    @IBOutlet weak var venueNameLabel: UILabel!
    
    
    @IBAction func openMaps(sender: UIButton) {
        let url = NSURL(string: "http://maps.apple.com/maps?saddr=Current%20Location&daddr=\(mealObject.longitudeOfVenue),\(mealObject.latitudeOfVenue)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Do any additional setup after loading the view
        
        
    }
    
}
