//
//  ResultsViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/31/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner
import Alamofire
import SwiftyJSON

class ResultsViewController: UIViewController {

    
    var mealObject: MealObject!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var openMapsButton: UIButton!
    @IBOutlet weak var venueNameLabel: UILabel!

    @IBAction func openMaps(sender: UIButton) {
        let url = NSURL(string: "http://maps.apple.com/maps?saddr=Current%20Location&daddr=\(self.mealObject.latitudeOfVenue),\(self.mealObject.longitudeOfVenue)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.mealObject.priceValue != "" {
        self.priceLabel.text = self.mealObject.priceValue
        } else {
            self.priceLabel.text = "n/a"
        }
        
        if self.mealObject.mealTitle != "" {
        self.mealTitleLabel.text = self.mealObject.mealTitle
        } else {
            self.mealTitleLabel.text = "Mystery Meal"
        }
        
        
        if self.mealObject.mealDescription != "" {
        self.mealDescriptionLabel.text = self.mealObject.mealDescription
        } else {
            self.mealDescriptionLabel.text = "No description is available for this meal"
        }
        
        if self.mealObject.addressofVenue != "" {
        self.venueAddressLabel.text = self.mealObject.addressofVenue
        } else {
            self.venueAddressLabel.text = ""
        }
        
        if self.mealObject.nameOfVenue != "" {
        self.venueNameLabel.text = self.mealObject.nameOfVenue
        } else {
            self.venueNameLabel.text = "Mystery Restaurant"
        }
//        let distMeters: Double = Double(self.mealObject.distanceToVenue)
//        let conversionToMiles: Double = 0.000621371
//        
//        self.distanceLabel.text = "\(distMeters * conversionToMiles)"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        // Do any additional setup after loading the view
        
    }
    
    
}
