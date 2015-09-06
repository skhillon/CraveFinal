//
//  CategoryViewController.swift
//  CraveFinal
//
//  Created by Sarthak Khillon on 8/31/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell" // FIX: delete, not being used

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var counter = 0
    
    var selectedCategories: [String] = []
    
    let categoryBank = ["Afghan", "African", "American", "Asian", "Caribbean", "Chinese", "Deli", "Eastern European", "French", "German", "Hawaiian", "Indian", "Indonesian", "Italian", "Mediterranean", "Mexican", "Persian", "Pizza", "Seafood", "Thai"]
    
    let tagImages = ["Afghan.png", "African.png", "American.png", "Asian.png", "Caribbean.png", "Chinese.png", "Deli.png", "EastEuro.png", "French.png", "German.png", "Hawaiian.png", "Indian.png", "Indonesian.png", "Italian.png", "Mediterranean.png", "Mexican.png", "Persian.png", "Pizza.png", "Seafood.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent // FIX: this is fine, but you know you can set this in Storyboard right?
        
        navigationController?.setNavigationBarHidden(false, animated: false) // FIX: was it hiding itself or animating before you set this?
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as [NSObject : AnyObject]
        // FIX: since you have multiple lines of code all related to prettifying the navbar, consider moving them into a helper method, or at least adding comments saying what the block of code is doing
        
        // FIX: add a comment explaining why this is needed - ie when you come back to this page it should stay enabled
        if selectedCategories.isEmpty {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true

        }
        
        // trying to hide done button when they have 0 values selected.
        
        //        if selectedCategories.count <= 0 {
        //            doneButton.enabled = false
        //            doneButton.userInteractionEnabled = false
        //            doneButton.alpha = 0.5
        //        } else {
        //            doneButton.enabled = true
        //            doneButton.userInteractionEnabled = true
        //            doneButton.alpha = 1.0
        
        println("I'M HERE!") // FIX: me too, don't forget to delete the unused code above

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsMultipleSelection = true
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine // FIX: this is fine, but you know you can set this in Storyboard right?
        tableView.separatorColor = UIColor.grayColor() // FIX: this is fine, but you know you can set this in Storyboard right?
    }

    
    func segueToHomeScreen() {
        // FIX: are you using this anywhere?
        self.performSegueWithIdentifier("segueToHomeScreen", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditSegue" { // FIX: not a good segue name, should be something like "ingredients" and adding "Segue" at the end is a bit redundant :p
            if let destinationVC = segue.destinationViewController as? IngredientSelectionViewController {
                destinationVC.selectedCategories = self.selectedCategories
            }
        }
    }
    
    // FIX: can delete this method - only needed if you want more than 1 section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryBank.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var category = categoryBank[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategoryTableViewCell // FIX: again, your naming conventions suck. "Cell" really?
        
        cell.categoryName.text = category
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryTableViewCell
        //println(cell)
        var bgColorView = UIView()
        var colorSelected = UIColor(red: 1.0, green: 0.5, blue: 0, alpha: 0.7)
        bgColorView.backgroundColor = colorSelected
        cell.selectedBackgroundView = bgColorView
        
        if self.counter > 4 {
            println("Error Counter is \(counter)")
            println("Cannot select more than 5 categories")
            let alert = UIAlertController(title: "Oops!", message: "Cannot select more than 5 categories.", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
            alert.addAction(alertAction)
            presentViewController(alert, animated: true) { () -> Void in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
            //cell.alpha = 1.0
            
        } else {
            self.selectedCategories.append(cell.categoryName.text!)
            counter++
            cell.alpha = 1.0
            println("From selected \(selectedCategories)")
            
        }
        if selectedCategories.isEmpty {
            doneButton.enabled = false

        } else {
            doneButton.enabled = true

        }

    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryTableViewCell
        
        // FIX: this bit is getting complicated enough that I'd move it to an appropriately named helper
        var found: Int?  // <= will hold the index if it was found, or else will be nil
        for i in (0...(selectedCategories.count - 1)) {
            if selectedCategories[i] == "\(cell.categoryName.text!)" {
                found = i
            }
        }
        if (found != nil) {
            self.selectedCategories.removeAtIndex(found!)
            cell.alpha = 1.0
            counter--
        }
        
        // FIX: duplicate code here!! Create helper method to call instead, like "updateDoneButtonUI" or something usefully named
        if selectedCategories.isEmpty {
            doneButton.enabled = false

        } else {
            doneButton.enabled = true

        }
        
        println("From deselected \(selectedCategories)")
        
    }
}
