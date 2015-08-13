//
//  Ingredient.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/12/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class Ingredient: Object {
    dynamic var ingredient: String = ""
    dynamic var ingredientKey: String = ""
    
    override class func primaryKey() -> String {
        return "ingredientKey"
    }
}

/*
    var relevantIngredients: [Ingredient] = []
    var ingredients: Ingredient!
    var relevantIngredientsLiked: RealmIngredientLiked = RealmIngredientLiked()
*/