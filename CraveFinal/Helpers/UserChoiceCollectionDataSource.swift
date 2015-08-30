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
    
    var finishedMealsArray: [MealObject]!
    
    var tempSortedVenues: [(String, Int, String, Double, Double, String)]!
    
    var numRestaurantsToQuery = 0
    var numQueriesReturned = 0
    
    var dumbo = 0
    
    var ingSelectionVC = IngredientSelectionViewController()
    var foodCategories: [String]!
    var ingredientData: [String]!
    var numElements: Int!

    
//    var foodCategoriesObject: Results<RealmRelevantCategoryTags>!
//    var foodCategories: List<Tag> = List<Tag>()
//    var ingredientDataObject: Results<RealmIngredientLiked>!
//    var ingredientData: List<Ingredient> = List<Ingredient>()
    
    //var mealObject = MealObject()
    var foundMeals: [MealObject] = []
    var sortedFoundMeals: [MealObject] = []
    
    let CLIENT_ID = "GBFQRRGTBCGRIYX5H204VMOD1XRQRYDVZW1UCFNFYQVLKZLY"
    let CLIENT_SECRET = "KZRGDLJNGKDNVWSK2YID2WBAKRH2KBQ2ROIXPFW5FOFSNACU"
    
    
    var venueInformation: [(String, Int, String, Double, Double, String)] = [] //name, distance, venueID
    var finishedVenueIdArray: [String] = []

    
    required init(){
        foodCategories = ingSelectionVC.selectedTags
        ingredientData = ingSelectionVC.userIngredients
        numElements = foodCategories.count
    }
    
    
    /**
    Gets the user's restaurant preferences based on the categories of food they've selected. By the end of this function there is valid information on nearby restaurants.
    
    @param long: User's coordinate longitude
    @param lat: User's coordinate latitude
    @param getUserSuggestionsCallback: A callback which takes the finished VenueID array and returns void. Should change to tuple soon.
    @return void
    */
    func getUserSuggestions(long: CLLocationDegrees, lat: CLLocationDegrees, getUserSuggestionsCallback: ([(String, Int, String, Double, Double, String)] -> Void))  {
        
        var numCategoriesQueried = 0
        var categories: [String] = []
        
        for tag in foodCategories {
            categories.append(tag)
        }
        
        var longitude = long as Double
        var latitude = lat as Double
     
        //println(categories.count)
        println("Ingredient data: \(self.ingredientData.count)")
        
        for tag in categories {
            
            let requestString: String = "https://api.foursquare.com/v2/venues/search?ll=\(latitude),\(longitude)&categoryId=\(tag)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20150814"
            
            println("venues string is " + "\(requestString)")
            Alamofire.request(.GET, requestString).responseString() {
                (_, _, responseBody, _) in
                
                numCategoriesQueried++
                let data = responseBody!.dataUsingEncoding(NSUTF8StringEncoding)
                let json = JSON(data: data!)
                let checker = json["meta"]["code"].intValue
                
                if checker == 404 {
                    println("venues request page not found")
                } else if checker == 403 {
                    println("venues rate limit exceeded")
                } else if checker == 200 {
                    let venues = json["response"]["venues"].arrayValue
                        //println(venues)
                        self.numRestaurantsToQuery += venues.count
                        //println("Restaurants that match the initial tag search: \(self.numRestaurantsToQuery)")
                    
                    for venue in venues {
                        let venueDict = venue.dictionary
                        //println(venueDict)
                        let name = venueDict!["name"]!.stringValue
                        let venueId = venueDict!["id"]!.stringValue
                        let location = venueDict!["location"]!.dictionary
                        let distance = location!["distance"]!.intValue
                        let lng = location!["lng"]!.doubleValue
                        let lat = location!["lat"]!.doubleValue
                        let addressArray = location!["formattedAddress"]!.arrayValue
                        let add = "\(addressArray[0])," + " \(addressArray[1])"
                        
                        let tempTuple = (name, distance, venueId, lng, lat, add)
                        self.venueInformation.append(tempTuple)
                    }

                    
                        if categories.count ==  numCategoriesQueried {
                            self.tempSortedVenues = self.sortVenues(self.venueInformation)
                            //println(self.venueInformation)
                            //self.finishedVenueIdArray = self.filterVenues(tempSortedVenues)
                            println("Number of categories:\(categories.count)")
                            println("Number of categories  Queried:\(numCategoriesQueried)")
                            getUserSuggestionsCallback(self.tempSortedVenues!)
                        } // if
                    
                } // response validity
            } // alamofire
        }// for loop
    }

    /*
    sorts venue information tuple
    
    @param unfilteredVenueInfo: array of tuples containing restaurant name, distance from user, and venueID
    @return same, but sorted
    */
    func sortVenues(unfilteredVenueInfo: [(String, Int, String, Double, Double, String)]) -> [(String, Int, String, Double, Double, String)] {
        //sort by distance
        
        var venueInfo: [(String, Int, String, Double, Double, String)] = unfilteredVenueInfo
        
        for venue in venueInfo {
            //println(venue)
        }
        
        func sorter(t1: (String, Int, String, Double, Double, String), t2: (String, Int, String, Double, Double, String)) -> Bool {
            return t1.1 < t2.1
        }
        
        var sortedVenueInfo = venueInfo.sorted({sorter($0, $1)})
        //println(sortedVenueInfo)
        
        return sortedVenueInfo
        
    }
    
//    /*
//    filters venues to nearest n venues, either hardcoded or something it depends on what you want. Maybe have user filter it out?
//    
//    @param sortedVenueInfo: what you got from sortedVenueInfo
//    @return: filtered out venueID array of strings.
//    */
//    func filterVenues(sortedVenueInfo: [(String, Int, String)]) -> [String] {
//        var idArray: [String] = []
//        var filteredArray: [String] = []
//        
//        
//        for venueElement in sortedVenueInfo {
//            idArray.append(venueElement.2)
//        }
//        println("idArray is \(idArray)")
//        for index in 0...self.venueInformation.count - 1 {
//            filteredArray.append(idArray[index])
//            //filteredArray.insert(idArray[index], atIndex: index)
//        }
//        return filteredArray
//    }
    
    func findMeals(venueTuple: [(String, Int, String, Double, Double, String)], findMealsCallback: ([MealObject] -> Void)) {
        
        let venuesToSearch = venueTuple
        //println("number of restaurants which will have its menus parsed: \(venuesToSearch.count)")
        
        
        for venue in venuesToSearch {
            
            let requestString = "https://api.foursquare.com/v2/venues/\(venue.2)/menu?client_id=\(self.CLIENT_ID)&client_secret=\(self.CLIENT_SECRET)&v=20150814"
            println("menu string is " + "\(requestString)")
            //println("Venue is \(venue)")
            
            
            Alamofire.request(.GET, requestString).responseString() {
                (_, _, responseBody, _) in
                
                self.numQueriesReturned++
                //println("Number of restaurants whose menus have been successfully parsed: \(self.numQueriesReturned)")
                
                let data = responseBody!.dataUsingEncoding(NSUTF8StringEncoding)
                let json = JSON(data: data!)
                let checker = json["meta"]["code"].intValue
                
                if checker == 404 {
                    println("meals request page not found")
                } else if checker == 403 {
                    println("meals rate limit exceeded")
                } else if checker == 200 {
                    let menuContainer = json["response"]["menu"]["menus"].dictionary
                        let menuCount = menuContainer!["count"]!.int!
                        //println(menuCount)
                        let menuItems = menuContainer!["items"]?.arrayValue
                    
                    
                        if let menuElements = menuItems {
                            //println(menuElements.count)
                            for item in menuElements {
                                let menuSections = item["entries"].dictionaryValue //subheadings in menus
                                let subheadings = menuSections["items"]!.arrayValue
                                //println(subheadings.count)
                                for sub in subheadings {
                                    let entries = sub["entries"].dictionaryValue
                                    let food = entries["items"]!.arrayValue
                                    
                                    //println(food.count)
                                    
                                    //println("Food count is \(food.count)")
                                    
                                    
                                    for foodStuff in food {
                                        self.dumbo++
                                        var mealObject = MealObject()
                                        
                                        let mealTitle = foodStuff["name"].stringValue
                                        let mealDescription = foodStuff["description"].stringValue
                                        let priceValue = foodStuff["price"].stringValue
                                        
                                        mealObject.mealTitle = mealTitle
                                        mealObject.mealDescription = mealDescription
                                        mealObject.priceValue = priceValue
                                        mealObject.nameOfVenue = venue.0
                                        mealObject.distanceToVenue = venue.1
                                        mealObject.venueId = venue.2
                                        mealObject.longitudeOfVenue = venue.3
                                        mealObject.latitudeOfVenue = venue.4
                                        mealObject.addressofVenue = venue.5
                                        
//                                        checks if any of the above values are empty before appending it to the valid foundMeals array
                                        if mealObject.mealTitle != "" || mealObject.mealDescription != "" || mealObject.priceValue != "" || mealObject.nameOfVenue != "" || mealObject.distanceToVenue != 0 || mealObject.venueId != "" || mealObject.longitudeOfVenue != 0 || mealObject.latitudeOfVenue != 0 || mealObject.addressofVenue != ""
                                        {
                                            self.foundMeals.append(mealObject)
                                        }
                                        

                                        
//                                        for meal in self.foundMeals {
//                                           
//                                            
//                                            meal.mealTitle = mealTitle
//                                            meal.mealDescription = mealDescription
//                                            meal.priceValue = priceValue
//                                        }
                                    }// for
                                }
                            }

                        }// if
                    
                } // checker elseif
                
                else {
                    println("Error in retrieving JSON")
                }
                
                //println("THE NUMBER OF TOTAL MEALOBJECTS CREATED: \(self.dumbo)")
                
                if self.numQueriesReturned == venuesToSearch.count
                {
                    //println(self.foundMeals.count)
                    //self.foundMeals.append(self.mealObject)
                    self.finishedMealsArray = self.finishUp()
                    findMealsCallback(self.finishedMealsArray)
                }

            }
            
        }
        
     
    } // end function

    func finishUp() -> [MealObject] {
        self.searchMealDescriptions(self.foundMeals)
        self.sortedFoundMeals = self.sortMeals(self.foundMeals)
        return sortedFoundMeals
    }
    
    func searchMealDescriptions(meals: [MealObject]) {
        for mealItem in meals {
            
            let mealDescription = mealItem.mealDescription // [String] of meal descriptions
            let characterSet: NSCharacterSet = NSCharacterSet.punctuationCharacterSet()
            let mealDescriptionWordsArray: [String] = (mealDescription.componentsSeparatedByCharactersInSet(characterSet) as NSArray).componentsJoinedByString("").componentsSeparatedByString(" ")
            var description: [String] = []
            for word in mealDescriptionWordsArray {
                description.append(word.lowercaseString)
            }
            
//            println(description)
            //let userIngredientsLikedArray = self.ingredientData
            
            mealItem.score = calcScore(description, userIngredientBank: self.ingredientData)
        }
    }
    
    func calcScore(descriptionArray: [String], userIngredientBank: [String]) -> Double {
        var userFound: Double = 0
        
        for word in descriptionArray {
            for ing in userIngredientBank {
                    if word == ing {
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