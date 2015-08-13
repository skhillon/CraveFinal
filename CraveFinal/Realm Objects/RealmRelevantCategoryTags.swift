//
//  RealmRelevantCategoryTags.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/12/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class RealmRelevantCategoryTags: Object {
   let relevantTags = List<Tag>()
    dynamic var categoryTagSelectedKey: String = ""
    
    override class func primaryKey() -> String {
        return "categoryTagSelectedKey"
    }
}
