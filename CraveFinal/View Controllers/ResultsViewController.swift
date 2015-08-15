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
    
    // I need to get these values from the specific MealObject that is stored in the cell I clicked on. How?
    //indexpath.row, get that value, store it somewhere, and then prepareforsegue send it here.
    
    var mealObject: MealObject!
    // Currently hardcoded values.
    //wait this is already stored in mealObject wat r u doing y u make again
//    let longitudeOfVenue: Double!
//    let latitudeOfVenue: Double!
//    let nameOfVenue: String!
//    let mealPrice: String!
    
    
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealDescriptionLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var openMapsButton: UIButton!
    @IBOutlet weak var venueNameLabel: UILabel!
    
    var paginatedScrollView: PaginatedScrollView?
    var restaurantPhotos: [UIImage]?
    
    
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
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Do any additional setup after loading the view
        setupScrollView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SwiftSpinner.show("Getting data...", animated: true)
    }
    
    func downloadArrayOfPhotos() {
        
    }
    func setupScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.scrollView.pagingEnabled = true
        self.scrollView.setAlwaysBounceVertical(false)
        var numberOfViews: Int = 3
        for var i = 0; i < numberOfViews; i++ {
            var xOrigin: CGFloat = i * self.view.frame.size.width
            var image: UIImageView = UIImageView(frame: CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height))
            image.image = UIImage.imageNamed("image_\(i + 1)")
            image.contentMode = UIViewContentModeScaleAspectFit
            self.scrollView.addSubview(image)
        }
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height)
        self.view.addSubview(self.scrollView)
    }
    
}
