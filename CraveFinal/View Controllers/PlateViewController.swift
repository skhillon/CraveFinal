//
//  PlateViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 7/15/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

class PlateViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var cellLocation = 0
    let locationHelper = LocationHelper.sharedInstance
    let userChoice = UserChoiceCollectionDataSource()
    var mealArray: [MealObject] = []
    //dynamic var mealList = List<MealObject>()
    
    func getResults(refreshControl: UIRefreshControl) {
        //handle meal results getting here. put this in a callback in the viewdidload
        
        self.tableView.reloadData()
        if (self.refreshControl != nil) {
            self.refreshControl!.endRefreshing()
        }
        mealArray = self.userChoice.getUserSuggestions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationHelper.setupLocation()

        mealArray = self.userChoice.getUserSuggestions()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableViewAutomaticDimension
        
        titleLabel.text = "Your Plate"
        subtitleLabel.text = "What can you see yourself eating?"
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.redColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.addTarget(self, action: "getResults", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellLocation = indexPath.row
        self.performSegueWithIdentifier("", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "plateSegue" {
            if let destinationVC = segue.destinationViewController as? ResultsViewController {
                destinationVC.mealObject = mealArray[cellLocation]
                destinationVC.nameOfVenue = mealArray[cellLocation].nameOfVenue
                destinationVC
            }
        }
    }
    
    
    //https://realm.io/news/building-tableviews-swift-ios8/
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell", forIndexPath: indexPath) as! PlateTableViewCell
        
        
        //        let meals = mealList.subscript([indexPath.row])
        //        print(indexPath.row)
        //        cell.mealTitleLabel.text = meals.mealTitle
        //        cell.descriptionLabel.text = meals.mealDescription
        //        cell.priceLabel.text = "\(meals.priceValue)"
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if mealList.count > 0 { // roundabout way of mealList.count
            return 1
        } else {
            var messageLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            messageLabel.text = "No data is currently available. Please pull down to refresh."
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        print("cell recreated ")
        //timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
}
