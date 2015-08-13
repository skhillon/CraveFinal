//
//  RealmIngredientsLiked.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/12/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class RealmIngredientLiked: Object {
    let ingredientsLiked = List<Ingredient>()
    dynamic var ingredientLikedKey: String = ""
    
    override class func primaryKey() -> String {
        return "ingredientLikedKey"
    }
}
