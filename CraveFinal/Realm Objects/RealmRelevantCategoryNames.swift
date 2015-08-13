//
//  RealmRelevantCategoryNames.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/12/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class RealmRelevantCategoryNames: Object {
    let relevantNames = List<Name>()
    dynamic var categoryNameSelectedKey: String = ""
    
    override class func primaryKey() -> String {
        return "categoryNameSelectedKey"
    }
}
