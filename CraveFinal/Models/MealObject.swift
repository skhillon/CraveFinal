//
//  MealObject.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/28/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class MealObject {
    
    var mealTitle = ""
    var mealDescription = ""
    var nameOfVenue = ""
    var priceValue = ""
    var score: Double = 0
    var longitudeOfVenue: Double = 0
    var latitudeOfVenue: Double = 0
    var distanceToVenue: Int = 0 // measured in meters
    var addressofVenue = ""
    var venueId = ""
    var saved = false
    
    func checkCompleted() -> Bool {
        if (mealTitle == "") || (mealDescription == "") || (nameOfVenue == "") /* || (priceValue == "") */ || (score == 0) || (longitudeOfVenue == 0) || (latitudeOfVenue == 0) || (distanceToVenue == 0) || (addressofVenue == "") || (venueId == "") {
            return true
        } else {
            return true
        }
    }
    
    
//    var relevantMatchedIngredients = [] // use .count function for sort priority in sortMeals()
//    var allMatchedIngredients = []
    
}
 