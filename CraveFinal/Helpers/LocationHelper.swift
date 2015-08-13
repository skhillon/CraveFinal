////
////  LocationHelper.swift
////  Crave App
////
////  Created by Pankaj Khillon on 7/25/15.
////  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
////
//
//import UIKit
//import CoreLocation
//
//typealias KILLINGIT = (longitude: CLLocationDegrees, latitude: CLLocationDegrees) -> Void
//
//class LocationHelper: NSObject, CLLocationManagerDelegate {
//    
//    static let sharedInstance = LocationHelper()
//    let locationManager = CLLocationManager()
//    var locValue: CLLocationCoordinate2D!
//    var longitude: CLLocationDegrees!
//    var latitude: CLLocationDegrees!
//    var callback: KILLINGIT!
//    
//    func setupLocation() {
////        dispatch_async(dispatch_get_main_queue(), { () ->  Void in
//
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        self.locationManager.delegate = self
//        self.locationManager.distanceFilter = kCLDistanceFilterNone
//        let status = CLLocationManager.authorizationStatus()
//        if status == .NotDetermined {
//            self.locationManager.requestWhenInUseAuthorization()
//        } else if status == CLAuthorizationStatus.AuthorizedWhenInUse
//            || status == CLAuthorizationStatus.AuthorizedAlways {
//                self.locationManager.startUpdatingLocation()
//        } else {
//            println("No permissions")
//        }
////        })
//        
//    }
//    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        locValue = locationManager.location.coordinate
//        self.longitude = locValue.longitude
//        self.latitude = locValue.latitude
//        callback(longitude: longitude, latitude: latitude)
//    }
//    
//    // TODO: func getCurrentLocation
//    // take a closure that takes CLLocation and returns Void
//    // check if locValue exists
//    // if not ???
//    // otherwise perform closure that takes CLLocation and returns Void
//    
//    override init() {
//        super.init()
//        self.locationManager
//        self.setupLocation()
//    }
//    
//}