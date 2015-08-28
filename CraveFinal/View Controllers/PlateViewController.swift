//
//  PlateViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/15/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation
//import SwiftSpinner

class PlateViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var cellLocation = 0
    
    // MARK: Data Model variables
    let userChoice = UserChoiceCollectionDataSource()
    var mealArray: [MealObject] = []
    var venueIDArray: [String] = []
    
    // MARK: location variables
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var longitude: CLLocationDegrees = CLLocationDegrees()
    var latitude: CLLocationDegrees = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.grayColor()

        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.orangeColor() // look at MakeNotes for custom colors
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.addTarget(self, action: "getResults", forControlEvents: UIControlEvents.ValueChanged)
        
        self.getResults()
    }
    
    func getResults() {
        var long = self.longitude
        var lat = self.latitude
        let hardLat = 38.666007
        let hardLong = -121.137887
        
        var success = false
        
        //SwiftSpinner.show("Connecting \nto database")
        self.userChoice.getUserSuggestions(hardLong, lat: hardLat) { (result) in
            
            //SwiftSpinner.show("Finding \nyour meals")
            self.userChoice.findMeals(result) { (anotherResult) in
                //SwiftSpinner.show("Almost \nthere!")
                //println(anotherResult)
                self.mealArray = (anotherResult)
               // SwiftSpinner.show("Completed", animated: false)
                
                self.tableView.reloadData()
                //self.refreshControl?.endRefreshing()
            }
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellLocation = indexPath.row
        self.performSegueWithIdentifier("plateSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "plateSegue" {
            if let destinationVC = segue.destinationViewController as? ResultsViewController {
                destinationVC.mealObject = mealArray[cellLocation]
            }
        }
    }
    
    
    //https://realm.io/news/building-tableviews-swift-ios8/
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell", forIndexPath: indexPath) as! PlateTableViewCell
        
        
        //        let meals = mealList.subscript([indexPath.row])
        //        print(indexPath.row)
        if self.mealArray[indexPath.row].mealTitle != "" {
        cell.mealTitleLabel.text = self.mealArray[indexPath.row].mealTitle
        } else {
            cell.mealTitleLabel.text = "Unnamed dish"
        }
        
        if self.mealArray[indexPath.row].mealDescription != "" {
        cell.restLabel.text = self.mealArray[indexPath.row].nameOfVenue
        } else {
            cell.restLabel.text = "No venue found"
        }
        
        if self.mealArray[indexPath.row].distanceToVenue != 0 {
            let meterDistance = self.mealArray[indexPath.row].distanceToVenue
            let mileDistance = round((Double(meterDistance) * 0.000621371 * 1000)/1000)
            cell.distanceLabel.text = "\(mileDistance)" + " mi"
        } else {
            cell.distanceLabel.text = "Distance n/a"
        }
        
        if self.mealArray[indexPath.row].priceValue != "" {
        cell.priceLabel.text = "$\(self.mealArray[indexPath.row].priceValue)"
        } else {
            cell.priceLabel.text = "n/a"
        }
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if mealArray.count > 0 {
            return 1
        } else {
            var messageLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            messageLabel.text = "No data is currently available. Please pull down to refresh."
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        print("cell recreated ")
        //timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue = locationManager.location.coordinate
        self.longitude = locValue.longitude
        self.latitude = locValue.latitude
    
    }

}