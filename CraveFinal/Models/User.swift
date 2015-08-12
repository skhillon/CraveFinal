//
//  User.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/30/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class User {
    //static let sharedInstance = User()
    //YOU SHOULD BE GETTING RELEVANTCATEGORIES NAMES FROM CATEGORIESSELECTIONCLASS!!!
    
    //dont need to inherit
    
    let collectionVC = CategoriesCollectionViewController()
    //dynamic var savedMeals: List<MealObject> = List<MealObject>()
    
    var realIngredientsLiked: List<RealmString> = List<RealmString>()
//    var relevantCategories: List<RealmString> = List<RealmString>()
//    var relevantTags: List<RealmString> = List<RealmString>()
    
//    required init() {
//        super.init()
//        var realIngredientsLiked = self.realIngredientsLiked
//        var relevantCategories = self.relevantCategories
//    }
    

//    func removeDuplicates(array: [String]) -> List<RealmString> {
//        var originals = array
//        let result = Array(Set(originals))
//        for i in 0...(result.count - 1) {
//            realIngredientsLiked.append(RealmString(value: result[i]))
//        }
//        return realIngredientsLiked
//    }
    
    func appendIngredients() {
                var ingredientsLiked: [String] = []
                var categories: [String] = []
        
        let realm = Realm()
        var ingredient = Ingredient()
        var realmIngredientsLiked = RealmIngredientLiked()
        var relevantCategoriesObject = realm.objects(RealmRelevantCategoryNames)
        var relevantCategoryNames = relevantCategoriesObject.first!.relevantNames
        
        realm.write{
            realm.add(realmIngredientsLiked, update: true)
        }
        
        for name in relevantCategoryNames {
            categories.append(name.name)
        }
        
        if relevantCategoryNames.count > 0 {
            
//        for i in 0...relevantCategories.count {
//            let stringHolder = relevantCategories[i].string
//            categories.append(stringHolder)
//        }
            
        for relevant in categories {
            switch relevant {
            case "Afghan":
                let arr: [String] = ["onions", "lamb", "rice", "lentils", "bolani", "mantwo", "aushak", "kabob"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }

            case "African":
                let arr: [String] = ["corn", "fennel", "miele", "carrot", "scallion", "chicken", "ginger", "garlic", "olive oil", "cumin", "turmeric"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "American":
                let arr: [String] = ["cheese", "chicken", "beef", "onion", "salt", "pepper", "soup", "pasta", "oil", "garlic", "tomato", "sauce", "butter", "milk", "potatoes", "corn"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Asian":
                let arr: [String] = ["soy", "sauce", "rice", "vinegar", "fish", "sriracha", "oyster", "coconut", "curry", "miso", "paste", "sesame", "oil", "sake", "rice", "noodles", "ginger", "lime", "cilantro"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Caribbean":
                let arr: [String] = ["allspice", "callaloo", "coconut", "molasses", "pigeon", "peas", "pepper", "plantains", "rum", "scotch", "chiles", "turmeric"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Chinese":
                let arr: [String] = ["bamboo shoots", "bean", "chile", "noodles", "sticky", "rice", "jasmine", "shiitake", "sichuan", "soy", "sesame ", "water", "chestnuts"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Deli":
                let arr: [String] = ["cold", "cuts", "salad", "pasta", "potato", "chicken", "tuna", "shrimp", "cheese", "eggplant", "pastrami", "roast beef", "salami", "ham", "turkey", "bologna"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "EastEuro":
                let arr: [String] = ["curd", "cheese", "kohlrabi", "peperivka", "kovbasa", "sorrel", "squash", "vegeta"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "French":
                let arr: [String] = ["baguette", "butter", "cheese", "fleur", "herbes", "provence", "leeks", "mustard", "olive oil", "shallots", "tarragon", "chicken", "vinegar", "wine"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "German":
                let arr: [String] = ["pork", "beef", "chicken", "duck", "goose", "prunes", "apples", "venison", "boar", "hare", "pheasant", "trout", "potato", "dumplings", "cabbage", "carrots", "radishes", "turnips", "asparagus"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Hawaiian":
                let arr: [String] = ["taro", "sweet potato", "purple yam", "breadfruit", "sea", "mineral", "ti", "hala", "limpets", "kukui", "imu", "beef", "pork", "chicken", "butterfish", "soy sauce", "sesame oil", "coconut milk", "squid", "cornstarch"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Indian":
                let arr: [String] = ["lentils", "chickpeas", "cardamom", "chili", "cinnamon", "coriander", "cumin", "masala", "ginger", "mustard seed", "onion", "garlic", "turmeric", "rice", "cheese", "chicken", "beans"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Indonesian":
                let arr: [String] = ["rice", "coconut", "turmeric", "wheat", "noodles", "bakpao", "cakwe", "yam", "sweet", "potato", "taro", "cassava", "maize", "breadfruit", "jackfruit", "spinach", "papaya", "cassava", "cabbage", "potato", "carrot", "beef", "chicken", "duck", "goat", "lamb"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Italian":
                let arr: [String] = ["tomatoes", "pasta", "rice", "flour", "beans", "bread", "artichoke", "olives", "olive oil", "garlic", "prosciutto", "basil", "mozzarella", "balsamic", "wine", "marsala", "parmesan"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Mediterranean":
                let arr: [String] = ["olive oil", "lamb", "onions", "pepper", "tomato", "phyllo", "spinach", "feta", "cheese", "hummus", "chickpeas", "garlic", "eggplant", "cinnamon", "grape", "rice", "chicken", "beef", "tahini"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Mexican":
                let arr: [String] = ["avocadoes", "beans", "cheese", "chipotle", "chocolate", "sour", "cream", "lime", "oregano", "poblanos", "tomatoes", "tortilla", "salsa"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Pizza":
                let arr: [String] = ["wheat", "flour", "dough", "tomato", "garlic", "onion", "basil", "pepperoni", "bacon", "beef", "chicken", "italian", "sausage", "breast", "salami", "ham", "cheese", "ranch", "marinara"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Persian":
                let arr: [String] = ["garbanzo beans", "onion", "garlic cloves", "garlic", "parsley", "flour", "salt", "cumin", "coriander", "cardamom", "fava beans", "chickpeas", "pita bread"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Seafood":
                let arr: [String] = ["shrimp", "tuna", "shellfish", "shark", "salmon", "sushi", "squid", "fish", "fillet", "cod", "mackerel", "anchovies"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            case "Thai":
                let arr: [String] = ["fish", "sauce", "nam", "pla", "anchovies", "cilantro", "basil", "coriander", "chile", "coconut", "milk", "palm", "lemongrass", "bamboo", "beancurd", "beansprouts"]
                for ingredient in arr {
                    ingredientsLiked.append(ingredient)
                }
                for i in 0...arr.count - 1 {
                    ingredient.ingredient = arr[i]
                    
                    realm.write {
                        realmIngredientsLiked.ingredientsLiked.append(ingredient)
                        println(ingredient)
                    }
                }
            default:
                println("No ingredients appended")
            }
        }
        //realIngredientsLiked = removeDuplicates(ingredientsLiked)
        
    } else {
        println("nope")
        // relevantCategories should be populated
        }
        
    }
}