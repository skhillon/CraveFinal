//
//  ChooseHelper.swift
//  Crave App
//
//  Created by Pankaj Khillon on 8/4/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import CoreLocation

class ChooseHelper {
    
    let CLIENT_ID = "GBFQRRGTBCGRIYX5H204VMOD1XRQRYDVZW1UCFNFYQVLKZLY"
    let CLIENT_SECRET = "KZRGDLJNGKDNVWSK2YID2WBAKRH2KBQ2ROIXPFW5FOFSNACU"
    
    let realm = Realm()
    
    var ingredientDataObject: Results<RealmIngredientLiked>!
    var ingredientData: List<Ingredient> = List<Ingredient>()
    
    //var currentUser = realm.objects(User)
    var mealObject = MealObject()
    var foundMeals: [MealObject] = []
    var sortedFoundMeals: [MealObject] = []
    
    let locationHelper = LocationHelper.sharedInstance
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!
    
//    var ingredientData:List<RealmString>! //= currentUser.ingredientsLiked
    //var categoryTagSearch = currentUser.relevantCategories
    
    required init(){
        self.ingredientDataObject = realm.objects(RealmIngredientLiked)
        self.ingredientData = ingredientDataObject.first!.ingredientsLiked
    }
    
//    var userChoice = UserChoiceCollectionDataSource() {
//        didSet {
//            self.longitude = userChoice.longitude
//            self.latitude = userChoice.latitude
//        }
//    }
    
    func locateVenue(query: String) -> [MealObject] {
        
        let searchQuery = query
        Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/suggestCompletion?ll=\(self.longitude),\(self.latitude)&query=\(searchQuery)&client_id=\(self.CLIENT_ID)&client_secret=\(self.CLIENT_SECRET)&v=20150729").responseJSON() { (_, _, data, _) in
            let json: JSON = data as! JSON
                if json["meta"]["code"].intValue == 200 { //if #3
                    for venue in json["response"]["minivenues"].arrayValue {
                        self.mealObject.venueId = venue["id"].stringValue
                        self.mealObject.nameOfVenue = venue["name"].stringValue
                        self.mealObject.distanceToVenue = venue["location"]["distance"].intValue
                        self.mealObject.addressofVenue = venue["location"]["address"].stringValue
                        self.foundMeals.append(self.mealObject)
                    }
                    
                } else {
                    println("Error in retrieving JSON")
                } // end else
                
        
        } //end Alamofire
        
        var processedMealData: [MealObject] = []
        for i in 0...self.foundMeals.count {
            processedMealData.append(foundMeals[i])
        }
        searchMealDescriptions(processedMealData)
        sortedFoundMeals = sortMeals(processedMealData)
        return sortedFoundMeals
    } //end function
    
    func searchMealDescriptions(meals: [MealObject]) {
        
        var processedIngredientData: [String] = []
        
        for ing in ingredientData {
            processedIngredientData.append(ing.ingredient)
        }
        let mealObjectArray = meals
//
//        for i in 0...ingredientData.count {
//            processedIngredientData.append(ingredientData[i].string)
//        }
        for mealItem in mealObjectArray {
            
            let mealDescription = mealItem.mealDescription // [String] of meal descriptions
            let characterSet: NSCharacterSet = NSCharacterSet.punctuationCharacterSet()
            let mealDescriptionWordsArray: [String] = (mealDescription.componentsSeparatedByCharactersInSet(characterSet) as NSArray).componentsJoinedByString("").componentsSeparatedByString(" ")
            //let userBankArray = ingredientData
            
            mealItem.score = calcScore(mealDescriptionWordsArray, userArray: processedIngredientData)
        }
    }
    
    func calcScore(wordArray: [String], userArray: [String]) -> Double {
        let userBank = userArray
        var userFound: Double = 0
        let descriptionArray = wordArray
        for word in descriptionArray {
            for comparison in userBank {
                if word == comparison {
                    userFound++
                }
            }
        }
        let score = userFound / Double(userBank.count)
        return score
    }
    
    func sortMeals(meals: [MealObject]) -> [MealObject] { //sort by score
        var mealObjectArray = meals
        mealObjectArray.sort({ $0.score > $1.score })
        return mealObjectArray
    }
}
