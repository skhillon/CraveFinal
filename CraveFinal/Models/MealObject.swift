//
//  MealObject.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/28/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class MealObject: Object {
    
    dynamic var mealTitle = ""
    dynamic var mealDescription = ""
    dynamic var nameOfVenue = ""
    dynamic var priceValue = ""
    dynamic var score: Double = 0
    dynamic var longitudeOfVenue: Double = 0
    dynamic var latitudeOfVenue: Double = 0
    dynamic var distanceToVenue: Int = 0 // measured in meters
    dynamic var addressofVenue = ""
    dynamic var venueId = ""
    dynamic var saved = false
    
    func checkCompleted() -> Bool {
        if (mealTitle == "") || (mealDescription == "") || (nameOfVenue == "") /* || (priceValue == "") */ || (score == 0) || (longitudeOfVenue == 0) || (latitudeOfVenue == 0) || (distanceToVenue == 0) || (addressofVenue == "") || (venueId == "") {
            return false
        } else {
            return true
        }
    }
    
    
//    var relevantMatchedIngredients = [] // use .count function for sort priority in sortMeals()
//    var allMatchedIngredients = []
    
}
 