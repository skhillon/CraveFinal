//
//  UserChoiceCollectionDataSource.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/20/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
//import Alamofire
import SwiftyJSON
import RealmSwift

class UserChoiceCollectionDataSource {
    
    var currentUser = Realm().objects(User)
    var mealObject = MealObject()
    var foundMeals: List<MealObject> = List<MealObject>()
    var foodCategories: List<RealmString> = List<RealmString>()
    var sortedMealObjects: [MealObject] = []
    
    var ingredientData:List<RealmString> = List<RealmString>()
    
    lazy var numElements: Int = { return self.foodCategories.count }()
    
    let CLIENT_ID = "GBFQRRGTBCGRIYX5H204VMOD1XRQRYDVZW1UCFNFYQVLKZLY"
    let CLIENT_SECRET = "KZRGDLJNGKDNVWSK2YID2WBAKRH2KBQ2ROIXPFW5FOFSNACU"
    
    let locationHelper = LocationHelper.sharedInstance
    
    var venueInformation: [(String, Int, String)] = []
    var finishedVenueIdArray: [String] = []
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!
    
    required init(){
        self.ingredientData = currentUser.first!.realIngredientsLiked
        self.foodCategories = currentUser.first!.relevantCategories
        
    }
    
    func getUserSuggestions() -> [MealObject] {
        
        var categories: [String]!
        for i in 0...foodCategories.count {
            categories.append(foodCategories[i].string)
        }
        
        // TODO: instead of returning [MealObject] take a closure as argument
        
        longitude = 38.665314 /*locationHelper.locValue?.longitude */
        latitude = -121.143955/* locationHelper.locValue?.latitude */
        for(var counter = 1; counter <= numElements; counter++) {
            if counter == numElements {
                let tempSortedVenues = sortVenues(venueInformation)
                finishedVenueIdArray = filterVenues(tempSortedVenues)
                foundMeals = findMeals(categories)
                
            }
                
            else {
                
                for tag in categories! {
                    
                    let urlString = "https://api.foursquare.com/v2/venues/search?ll=\(longitude),\(latitude)&categoryId=\(tag)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20150729"
                    
                    //println(urlString)
                    
                    if let url = NSURL(string: urlString) {
                        if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil) {
                            let json = JSON(data: data)
                            //print(json["response"]["venues"])
                            if json["meta"]["code"].intValue == 200 {
                                // we're OK to parse!
                                
                                let venues = json["response"]["venues"].arrayValue
                                
                                for venue in venues {
                                    let venueDict = venue.dictionary
                                    let name = venueDict!["name"]!.stringValue
                                    let id = venueDict!["id"]!.stringValue
                                    let location = venueDict!["location"]!.dictionary
                                    let distance = location!["distance"]!.intValue
                                    
                                    // println(name + " distance: \(distance)")
                                    let tempTuple = (name, distance, id)
                                    venueInformation.append(tempTuple)
                                    
                                    let mealObject = MealObject()
                                    mealObject.nameOfVenue = name
                                    mealObject.longitudeOfVenue = location!["lng"]!.doubleValue
                                    mealObject.latitudeOfVenue = location!["lat"]!.doubleValue
                                    mealObject.addressofVenue = location!["formattedAddress"]!.stringValue
                                    mealObject.distanceToVenue = location!["distance"]!.int!
                                    foundMeals.append(mealObject)
                                    
                                }
                            }
                            
                        }
                        
                    }
                    else {
                        println("Error in retrieving JSON")
                    }
                }
            }
            counter++
        }
        var returnedMeals: [MealObject] = []
        for i in 0...foundMeals.count {
            returnedMeals.append(foundMeals[i])
        }
        return returnedMeals
    }
    
    func sortVenues(unfilteredVenueInfo: [(String, Int, String)]) -> [(String, Int, String)] {
        //sort by distance
        
        var venueInfo: [(String, Int, String)] = unfilteredVenueInfo
        
        for venue in venueInfo {
            //println(venue)
        }
        
        func sorter(t1: (String, Int, String), t2: (String, Int, String)) -> Bool {
            return t1.1 < t2.1
        }
        
        var sortedVenueInfo = venueInfo.sorted({sorter($0, $1)})
        
        return sortedVenueInfo
        
    }
    
    func filterVenues(sortedVenueInfo: [(String, Int, String)]) -> [String] {
        var idArray: [String] = []
        var filteredArray: [String] = []
        for venueElement in sortedVenueInfo {
            idArray.append(venueElement.2)
        }
        for index in 0...4 {
            filteredArray.insert(idArray[index], atIndex: index)
        }
        return filteredArray
    }
    
    func findMeals(venueIDArray: [String]) -> List<MealObject> {
        let venuesToSearch = venueIDArray
        var sortedMealObjects: [MealObject] = []
        
        for venue in venuesToSearch {
            
            let urlString = "https://api.foursquare.com/v2/venues/\(venue)/menu?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20150729"
            
            println(urlString)
            if let url = NSURL(string: urlString) { // if #1
                if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil) { //if #2
                    let json = JSON(data: data)
                    if json["meta"]["code"].intValue == 200 { //if #3
                        let menuContainer = json["response"]["menu"]["menus"].dictionary
                        let menuCount = menuContainer!["count"]!.int!
                        println(menuCount)
                        if menuCount == 1 { //if #4
                            
                            let menuItems = menuContainer!["items"]!.arrayValue //lists all menus "main Menu"
                            for item in menuItems {
                                let menuSections = item["entries"].dictionaryValue //subheadings in menus
                                let subheadings = menuSections["items"]!.arrayValue
                                for sub in subheadings {
                                    let entries = sub["entries"].dictionaryValue
                                    let food = entries["items"]!.arrayValue
                                    for foodStuff in food {
                                        for meal in foundMeals {
                                            let mealTitle = foodStuff["name"].stringValue
                                            let mealDescription = foodStuff["description"].stringValue
                                            let priceValue = foodStuff["price"].stringValue
                                            
                                            meal.mealTitle = mealTitle
                                            meal.mealDescription = mealDescription
                                            meal.priceValue = priceValue
                                            println(meal.mealTitle)
                                            println(meal.mealDescription)
                                            println(meal.nameOfVenue)
                                            println(meal.distanceToVenue)
                                            println(meal.addressofVenue)
                                            println(meal.longitudeOfVenue)
                                            println(meal.latitudeOfVenue)
                                        }
                                    }
                                }
                            }
                            
                        }// end if #4
                        
                    } else {
                        println("Error in retrieving JSON")
                    }
                    
                }
            } //end if #1
            searchMealDescriptions(foundMeals)
            sortedMealObjects = sortMeals(foundMeals)
        }
        var returnedMealObjects: List<MealObject> = List<MealObject>()
        for i in 0...sortedMealObjects.count {
            returnedMealObjects.append(sortedMealObjects[i])
        }
        return returnedMealObjects
    } // end function
    
    func searchMealDescriptions(meals: List<MealObject>) {
        
        var mealObjectList = meals
        var mealObjectArray: [MealObject] = []
        for i in 0...mealObjectList.count {
            mealObjectArray.append(mealObjectList[i])
        }
        for mealItem in mealObjectArray {
            
            let mealDescription = mealItem.mealDescription // [String] of meal descriptions
            let characterSet: NSCharacterSet = NSCharacterSet.punctuationCharacterSet()
            let mealDescriptionWordsArray: [String] = (mealDescription.componentsSeparatedByCharactersInSet(characterSet) as NSArray).componentsJoinedByString("").componentsSeparatedByString(" ")
            var description: [String] = []
            for word in mealDescriptionWordsArray {
                description.append(word.lowercaseString)
            }
            //let userIngredientsLikedArray = self.ingredientData
            
            mealItem.score = calcScore(description, userArray: self.ingredientData)
        }
    }
    
    func calcScore(wordArray: [String], userArray: List<RealmString>) -> Double {
        let userIngredientBank = userArray
        var userFound: Double = 0
        let descriptionArray = wordArray
        for word in descriptionArray {
            for comparison in userIngredientBank {
                if word == comparison {
                    userFound++
                }
            }
        }
        let score = userFound / Double(userIngredientBank.count)
        return score
    }
    
    func sortMeals(meals: List<MealObject>) -> [MealObject] {
        var mealObjectList = meals
        var mealObjectArray: [MealObject] = []
        for i in 0...mealObjectList.count {
            mealObjectArray.append(mealObjectList[i])
        }
        mealObjectArray.sort({ $0.score > $1.score })
        return mealObjectArray
    }
}