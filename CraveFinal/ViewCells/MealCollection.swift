//
//  MealCollection.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/19/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

class MealCollection {
    var name: String?
    //var icon: UIImage?
    
    init?(name: String/*, icon: UIImage*/) {
        self.name = name
        //self.icon = icon
        
        if name.isEmpty {
            return nil
        }
    }
}
