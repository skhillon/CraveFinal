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
        var myCoordinate = CLLocationCoordinate2DMake(self.mealObject.latitudeOfVenue, self.mealObject.longitudeOfVenue)
        
        var myPlacemark = MKPlacemark(coordinate: myCoordinate, addressDictionary: nil)
        
        var mapItem = MKMapItem(placemark: myPlacemark)
        
        mapItem.name = self.mealObject.nameOfVenue
        
        //You could also choose: MKLaunchOptionsDirectionsModeWalking
        var launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMapsWithLaunchOptions(launchOptions)
        
//        let url = NSURL(string: "http://maps.apple.com/maps?saddr=Current%20Location&daddr=\(self.mealObject.longitudeOfVenue),\(self.mealObject.latitudeOfVenue)")
//        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.priceLabel.text = self.mealObject.priceValue
        self.mealTitleLabel.text = self.mealObject.mealTitle
        self.mealDescriptionLabel.text = self.mealObject.mealDescription
        
        self.venueAddressLabel.text = self.mealObject.addressofVenue
        self.venueNameLabel.text = self.mealObject.nameOfVenue
//        let distMeters: Double = Double(self.mealObject.distanceToVenue)
//        let conversionToMiles: Double = 0.000621371
//        
//        self.distanceLabel.text = "\(distMeters * conversionToMiles)"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        // Do any additional setup after loading the view
        
    }
    
    
}
