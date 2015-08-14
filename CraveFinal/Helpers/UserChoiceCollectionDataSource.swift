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
import Alamofire
import SwiftyJSON
import RealmSwift

class UserChoiceCollectionDataSource {
    
    //    //var currentUser:Results<User>!
    //    var mealObject = MealObject()
    //    var foundMeals: List<MealObject> = List<MealObject>()
    //    var foodCategories: List<RealmString> = List<RealmString>()
    //
    //    var ingredientData:List<RealmString> = List<RealmString>()
    
    var numRestaurantsToQuery = 0
    var numQueriesReturned = 0
    
    var foodCategoriesObject: Results<RealmRelevantCategoryTags>!
    var foodCategories: List<Tag> = List<Tag>()
    var ingredientDataObject: Results<RealmIngredientLiked>!
    var ingredientData: List<Ingredient> = List<Ingredient>()
    
    
    var mealObject = MealObject()
    var foundMeals: [MealObject] = []
    var sortedFoundMeals: [MealObject] = []
    
    
    lazy var numElements: Int = { return self.foodCategories.count }()
    
    let CLIENT_ID = "GBFQRRGTBCGRIYX5H204VMOD1XRQRYDVZW1UCFNFYQVLKZLY"
    let CLIENT_SECRET = "KZRGDLJNGKDNVWSK2YID2WBAKRH2KBQ2ROIXPFW5FOFSNACU"
    
    //let locationHelper = LocationHelper.sharedInstance
    
    var venueInformation: [(String, Int, String)] = [] //name, distance, venueID
    var finishedVenueIdArray: [String] = []
    //    var longitude: CLLocationDegrees!
    //    var latitude: CLLocationDegrees!
    
    required init(){
        
        
        self.ingredientDataObject = realm.objects(RealmIngredientLiked)
        
        if self.ingredientDataObject.count != 0 {
            println("ingredient Data is good")
            self.ingredientData = ingredientDataObject.first!.ingredientsLiked
            //currentUser = Realm().objects(User)
            self.foodCategoriesObject = realm.objects(RealmRelevantCategoryTags)
            self.foodCategories = foodCategoriesObject.first!.relevantTags
            if self.foodCategories.count > 0 {
                println("foodCategories is good")
            }
            
            if self.foodCategories.first != nil {
                println("foodCategories contains valid tags")
                println(self.foodCategories.first)
            } else {
                println("foodCategories does not have existing tags")
            }
        } else {
            println("INGREDIENT DATA IS FUUUUUCKED UPPPP")
        }
        
        //self.ingredientData = currentUser.first!.realIngredientsLiked
        
    }
    
    func getUserSuggestions(long: CLLocationDegrees, lat: CLLocationDegrees, callback: ([MealObject] -> Void))  {
        
        var categories: [String] = []
        for tag in foodCategories {
            categories.append(tag.tag)
        }
        
        var longitude = long as Double
        var latitude = lat as Double
        
        for(var counter = 0; counter < numElements ; counter++) {
            let problemSolver = counter == numElements
            //println(problemSolver)
            
            //dispatch_async(dispatch_get_main_queue(), { () ->  Void in
            
            //println(categories.count)
            //println(self.ingredientData.count) //this should be more than just 5...
            
            for tag in categories {
                
                let requestString: String = "https://api.foursquare.com/v2/venues/search?ll=37.452042,-122.137489&categoryId=\(tag)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20150814"
                
                //println(requestString)
                Alamofire.request(.GET, requestString).responseString() {
                    (_, _, responseBody, _) in
                    //println("response")
                    //                        let responseDictionary = responseBody as! Dictionary<String, AnyObject>
                    //                        responseDictionary["response"]["confident"]
                    if let data = responseBody!.dataUsingEncoding(NSUTF8StringEncoding) {
                        let json = JSON(data: data)
                        if json["meta"]["code"].intValue == 200 {
                            // we're OK to parse!
                            
                            let venues = json["response"]["venues"].arrayValue
                            self.numRestaurantsToQuery += venues.count
                            println("Restaurants to query: \(self.numRestaurantsToQuery)")
                            
                            for venue in venues {
                                let venueDict = venue.dictionary
                                //println(venueDict)
                                let name = venueDict!["name"]!.stringValue
                                let venueId = venueDict!["id"]!.stringValue
                                let location = venueDict!["location"]!.dictionary
                                let distance = location!["distance"]!.intValue
                                
                                // println(name + " distance: \(distance)")
                                //                                let tempTuple = (name, distance, id)
                                //                                self.venueInformation.append(tempTuple)
                                
                                let mealObject = MealObject()
                                mealObject.nameOfVenue = name
                                mealObject.longitudeOfVenue = location!["lng"]!.doubleValue
                                mealObject.latitudeOfVenue = location!["lat"]!.doubleValue
                                mealObject.addressofVenue = location!["formattedAddress"]!.stringValue
                                mealObject.distanceToVenue = distance
                                mealObject.venueId = venueId
                                self.foundMeals.append(mealObject)
                                let tempTuple = (name, distance, venueId)
                                self.venueInformation.append(tempTuple)
                                
                                if self.venueInformation.count == self.numElements {
                                    let tempSortedVenues = self.sortVenues(self.venueInformation)
                                    //println(self.venueInformation)
                                    self.finishedVenueIdArray = self.filterVenues(tempSortedVenues)
                                    // println(finishedVenueIdArray)
                                    self.findMeals(self.finishedVenueIdArray, long: longitude, lat: latitude) { (result) in
                                        self.foundMeals = result
                                    }
                                    // println(foundMeals)
                                }
                                //println(self.foundMeals)
                            }
                        }
                    }
                    
                }
                
            }
            if self.numRestaurantsToQuery == self.numQueriesReturned {
            callback(self.foundMeals)
            }
            //})
        }
        //        println(foundMeals)
        //        return foundMeals
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
        for index in 0...(idArray.count - 1) {
            filteredArray.append(idArray[index])
            //filteredArray.insert(idArray[index], atIndex: index)
        }
        return filteredArray
    }
    
    func findMeals(venueIDArray: [String], long: CLLocationDegrees, lat: CLLocationDegrees, callback: ([MealObject]) -> Void) {
        let venuesToSearch = venueIDArray
        println("number of venues to search: \(venuesToSearch.count)")
        let longitude = long as Double
        let latitude = lat as Double
        //dispatch_async(dispatch_get_main_queue(), { () ->  Void in
        for venue in venuesToSearch {
            
            let requestString = "https://api.foursquare.com/v2/venues/\(venue)/menu?client_id=\(self.CLIENT_ID)&client_secret=\(self.CLIENT_SECRET)&v=20150814"
            //println(requestString)
            Alamofire.request(.GET, requestString).responseString() {
                (_, _, responseBody, _) in
                
                self.numQueriesReturned++
                println("Queries returned: \(self.numQueriesReturned)")
                //                if let url = NSURL(string: urlString) { // if #1
                //                    if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil) { //if #2
                if let data = responseBody!.dataUsingEncoding(NSUTF8StringEncoding) {
                    let json = JSON(data: data)
                    //println(json)
                    //println(json.description)
                    if json["meta"]["code"].intValue == 200 { //if #3
                        let menuContainer = json["response"]["menu"]["menus"].dictionary
                        let menuCount = menuContainer!["count"]!.int!
                        //println(menuContainer)
                        //if menuCount == 1 { //if #4
                        
                        let menuItems = menuContainer!["items"]?.arrayValue
                        if let menuElements = menuItems {
                            for item in menuElements {
                                let menuSections = item["entries"].dictionaryValue //subheadings in menus
                                let subheadings = menuSections["items"]!.arrayValue
                                //println(subheadings.count)
                                for sub in subheadings {
                                    let entries = sub["entries"].dictionaryValue
                                    let food = entries["items"]!.arrayValue
                                    //println(food.count)
                                    for foodStuff in food {
                                        // println(self.foundMeals.count)
                                        
                                        
                                        for meal in self.foundMeals {
                                            let mealTitle = foodStuff["name"].stringValue
                                            let mealDescription = foodStuff["description"].stringValue
                                            let priceValue = foodStuff["price"].stringValue
                                            
                                            meal.mealTitle = mealTitle
                                            meal.mealDescription = mealDescription
                                            meal.priceValue = priceValue
                                            
                                            
//                                            print(meal.mealTitle)
//                                            println(meal.priceValue)

                                            
                                            // this code is never run...
                                            if self.mealObject.checkCompleted() {
                                                self.foundMeals.append(self.mealObject)
                                                self.finishUp()
                                            }

                                        }

                                        callback(self.sortedFoundMeals)
                                    }
                                }
                            }
                        }
                        //}// end if #4
                    } else {
                        println("Error in retrieving JSON")
                    }
                }
                //                    }
                //                }
                
                
                
            }
            
        }
        
        
        //})
        
        //        var returnedMealObjects: List<MealObject> = List<MealObject>()
        //        for i in 0...sortedFoundMeals.count {
        //            returnedMealObjects.append(sortedFoundMeals[i])
        //        }
        //return sortedFoundMeals
    } // end function
    
    func finishUp() {
        self.searchMealDescriptions(self.foundMeals)
        println(self.foundMeals)
        self.sortedFoundMeals = self.sortMeals(self.foundMeals)
        println(self.sortedFoundMeals)
    }
    
    func searchMealDescriptions(meals: [MealObject]) {
        
        //        var mealObjectList = meals
        //        var mealObjectArray: [MealObject] = []
        //        for i in 0...mealObjectList.count {
        //            mealObjectArray.append(mealObjectList[i])
        //        }
        for mealItem in meals {
            
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
    
    func calcScore(wordArray: [String], userArray: List<Ingredient>) -> Double {
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
    
    func sortMeals(meals: [MealObject]) -> [MealObject] {
        var mealArray = meals
        //        var mealObjectList = meals
        ////        var mealObjectArray: [MealObject] = []
        //        for i in 0...meals.count {
        //            mealObjectArray.append(mealObjectList[i])
        //        }
        mealArray.sort({ $0.score > $1.score })
        return mealArray
    }
}