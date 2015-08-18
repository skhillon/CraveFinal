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
    var numRestaurantsToQuery = 0
    var numQueriesReturned = 0
    
    var dumbo = 0
    
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
    
    
    var venueInformation: [(String, Int, String)] = [] //name, distance, venueID
    var finishedVenueIdArray: [String] = []

    
    required init(){
        
        
        self.ingredientDataObject = realm.objects(RealmIngredientLiked)
        
        
        if self.ingredientDataObject.count != 0 {
            
            println("ingredient Data is good")
            self.ingredientData = ingredientDataObject.first!.ingredientsLiked
            println(self.ingredientData)
            
            self.foodCategoriesObject = realm.objects(RealmRelevantCategoryTags)
            self.foodCategories = foodCategoriesObject.first!.relevantTags // is this only getting afghan food?
            if self.foodCategories.count > 0 {
                println("foodCategories is good and food category count is \(self.foodCategories.count)")
            }
            
            if self.foodCategories.first != nil {
                println("foodCategories contains valid tags")
                println(self.foodCategories.first)
            } else {
                println("foodCategories does not have existing tags")
            }
        } else {
            println("Ingredient data invalid")
        }
        
        //self.ingredientData = currentUser.first!.realIngredientsLiked
        
    }
    
    
    /**
    Gets the user's restaurant preferences based on the categories of food they've selected. By the end of this function there is valid information on nearby restaurants.
    
    @param long: User's coordinate longitude
    @param lat: User's coordinate latitude
    @param getUserSuggestionsCallback: A callback which takes the finished VenueID array and returns void. Should change to tuple soon.
    @return void
    */
    func getUserSuggestions(long: CLLocationDegrees, lat: CLLocationDegrees, getUserSuggestionsCallback: ([String] -> Void))  {
        
        var numCategoriesQueried = 0
        var categories: [String] = []
        
        for tag in foodCategories {
            categories.append(tag.tag)
        }
        
        var longitude = long as Double
        var latitude = lat as Double
     
        
        //println(categories.count)
        println("Ingredient data: \(self.ingredientData.count)")
        
        for tag in categories {
            
            let requestString: String = "https://api.foursquare.com/v2/venues/search?ll=\(long),\(lat)&categoryId=\(tag)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20150814"
            
            //println(requestString)
            Alamofire.request(.GET, requestString).responseString() {
                (_, _, responseBody, _) in
                
                numCategoriesQueried++
                
                if self.checkForValidity(responseBody) == 200 {
                
                        let venues = json["response"]["venues"].arrayValue
                        println(venues)
                        self.numRestaurantsToQuery += venues.count
                        println("Restaurants that match the initial tag search: \(self.numRestaurantsToQuery)")
                    
                        self.createTuple(venue: [String])
                        
                        if categories.count ==  numCategoriesQueried {
                            let tempSortedVenues = self.sortVenues(self.venueInformation)
                            //println(self.venueInformation)
                            self.finishedVenueIdArray = self.filterVenues(tempSortedVenues)
                            println("Number of categories:\(categories.count)")
                            println("Number of categories  Queried:\(numCategoriesQueried)")
                            getUserSuggestionsCallback(self.finishedVenueIdArray)
                        } // if
                    
                } // response validity
            } // alamofire
        }// for loop
    }
    
    /*
    checks validity of JSON request
    
    @param response: JSON optional response string
    @response: integer, most likely 200 or 400, used in if statement in getUserSuggestions()
    */
    func checkForValidity(response: String?) -> Int {
        let data = response!.dataUsingEncoding(NSUTF8StringEncoding)
            let json = JSON(data: data!)
            return json["meta"]["code"].intValue
    }
    
    /*
    creates class-level tuple to be used in findMeals in later version
    
    @param venueJSONResponse: array of restaurants
    @return void
    */
    func createTuple(venueJSONResponse: [String]) {
        for venue in venueJSONResponse {
            let venueDict = venue.dictionary
            //println(venueDict)
            let name = venueDict!["name"]!.stringValue
            let venueId = venueDict!["id"]!.stringValue
            let location = venueDict!["location"]!.dictionary
            let distance = location!["distance"]!.intValue
        
            let tempTuple = (name, distance, venueId)
            self.venueInformation.append(tempTuple)
        }
    }

    /*
    sorts venue information tuple
    
    @param unfilteredVenueInfo: array of tuples containing restaurant name, distance from user, and venueID
    @return same, but sorted
    */
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
        println(sortedVenueInfo)
        
        return sortedVenueInfo
        
    }
    
    /*
    filters venues to nearest n venues, either hardcoded or something it depends on what you want. Maybe have user filter it out?
    
    @param sortedVenueInfo: what you got from sortedVenueInfo
    @return: filtered out venueID array of strings.
    */
    func filterVenues(sortedVenueInfo: [(String, Int, String)]) -> [String] {
        var idArray: [String] = []
        var filteredArray: [String] = []
        for venueElement in sortedVenueInfo {
            idArray.append(venueElement.2)
        }
        println("idArray is \(idArray)")
        for index in 0...self.venueInformation.count - 1 {
            filteredArray.append(idArray[index])
            //filteredArray.insert(idArray[index], atIndex: index)
        }
        return filteredArray
    }
    
    func findMeals(venueIDArray: [String], findMealsCallback: ([MealObject] -> Void)) {
        
        let venuesToSearch = venueIDArray
        println("number of restaurants which will have its menus parsed: \(venuesToSearch.count)")
        
        
        for venue in venuesToSearch {
            
            let requestString = "https://api.foursquare.com/v2/venues/\(venue)/menu?client_id=\(self.CLIENT_ID)&client_secret=\(self.CLIENT_SECRET)&v=20150814"
            println(requestString)
            println("Venue is \(venue)")
            
            
            Alamofire.request(.GET, requestString).responseString() {
                (_, _, responseBody, _) in
                
                self.numQueriesReturned++
                println("Number of restaurants whose menus have been successfully parsed: \(self.numQueriesReturned)")
                
                if self.checkForValidity(responseBody) == 200 {
                    let menuContainer = json["response"]["menu"]["menus"].dictionary
                        let menuCount = menuContainer!["count"]!.int!
                        //println(menuCount)
                        let menuItems = menuContainer!["items"]?.arrayValue
                    
                    
                        if let menuElements = menuItems {
                            println(menuElements.count)
                            self.assignMealObjects(menuElements)
                        }
                        
                        else {
                            println("Error in retrieving JSON")
                        }
                }
                
                println("THE NUMBER OF TOTAL MEALOBJECTS CREATED: \(self.dumbo)")
                
                if self.numQueriesReturned == venuesToSearch.count
                {
                    self.foundMeals.append(self.mealObject)
                    self.finishedMealsArray = self.finishUp()
                    findMealsCallback(self.finishedMealsArray)
                }

            }
            
        }
        
     
    } // end function

    func assignMealObjects(Elements: [AnyObject]) {
        for item in menuElements {
            let menuSections = item["entries"].dictionaryValue //subheadings in menus
            let subheadings = menuSections["items"]!.arrayValue
            //println(subheadings.count)
            for sub in subheadings {
                let entries = sub["entries"].dictionaryValue
                let food = entries["items"]!.arrayValue
            
                println(food.count)
            
                println("Food count is \(food.count)")
            
                
                for foodStuff in food {
                    
                    for meal in self.foundMeals {
                        self.dumbo++
                        let mealTitle = foodStuff["name"].stringValue
                        let mealDescription = foodStuff["description"].stringValue
                        let priceValue = foodStuff["price"].stringValue
                    
                        meal.mealTitle = mealTitle
                        meal.mealDescription = mealDescription
                        meal.priceValue = priceValue
                    }
                }
            }
        }
    }

    func finishUp() -> [MealObject] {
        self.searchMealDescriptions(self.foundMeals)
        //println(self.foundMeals)
        self.sortedFoundMeals = self.sortMeals(self.foundMeals)
        println(self.sortedFoundMeals)
        return sortedFoundMeals
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