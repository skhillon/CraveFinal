//
//  IngredientSelectionViewController.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/26/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//


import UIKit
import RealmSwift

// cell is called "IngredientCell"

// by default, all rows will be selected. It is then up to the user to select or deselect as they feel is necessary.

class IngredientSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cellLocation = 0
    
    var categoriesToEdit: [String] = []
    
    var categoryInformationDictionary: [String: [String]] = [:]
   
    var relevantIngredients: [Ingredient]!
    var ingredients: Ingredient!
    var relevantIngredientsLiked: RealmIngredientLiked!
    
    init() {
        for cat in categoriesToEdit {
            categoryInformationDictionary[cat] =
        }
    }
    
    func addToRealm(ingredientsArray: [String]) {
    
        ingredients = Ingredient()
        let arr: [String] = ingredientsArray
        
        var arrList: List<RealmString> = List<RealmString>()
        
        for a in arr {
            let realmA = RealmString
            realmA.string = a
            
            arrList.append(realmA)
        }
        
        ingredients.ingredient = arrList
        
        realm.write {
            self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
            realm.add(self.relevantIngredientsLiked)
        }
        
    }
    
    func removeFromRealm() {} // specify realm write delete
    
    // MARK: System functions

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.grayColor()
        tableView.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    // MARK: Table View Protocol
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellLocation = indexPath.row
       
        // set selected or deselected
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var category = categoriesToEdit[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as! IngredientSelectionViewCell
        
        
        cell.ingredientLabel.text =
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.categoriesToEdit.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // write to realm
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.alpha = 1.0
        
        let selected = self.categoriesToEdit[indexPath.row]
        
        // these errors are only here because there's nothing in the case statements
        switch(selected) {
            case "Afghan":
            case "African":
            case "American":
            case "Asian":
            case "Caribbean":
            case "Chinese":
            case "Deli":
            case "Eastern European":
            case "French":
            case "German":
            case "Hawaiian":
            case "Indian":
            case "Indonesian":
            case "Italian":
            case "Mediterranean":
            case "Mexican":
            case "Persian":
            case "Pizza":
            case "Seafood":
            case "Thai":
        default:
            
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // remove from realm
    }
    

}
