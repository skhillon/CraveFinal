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
    let longitudeOfVenue: Double = 37.4520420
    let latitudeOfVenue: Double = 122.1374890
    let nameOfVenue: String = "Mountain Mike's Pizza"
    
    
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var openMapsButton: UIButton!
    @IBOutlet weak var venueNameLabel: UILabel!
    
    
    @IBAction func openMaps(sender: UIButton) {
        
        let coords = CLLocationCoordinate2DMake(longitudeOfVenue, latitudeOfVenue)
        let placeMark = MKPlacemark(coordinate: coords, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: placeMark)
        
        mapItem.name = nameOfVenue
        
        //You could also choose: MKLaunchOptionsDirectionsModeWalking
        var launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Do any additional setup after loading the view
        
        
    }
    
}
