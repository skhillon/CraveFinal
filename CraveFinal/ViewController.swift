//
//  ViewController.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/11/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var objectThing = TestRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectThing.name = "ting"
        
        let realm = Realm()
        
        realm.write {
            realm.add(self.objectThing)
        }
        
        var testobjects: Results<TestRealm>! {
            didSet {
                println(testobjects)
            }
        }
        
        testobjects = realm.objects(TestRealm)
        println(testobjects)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

