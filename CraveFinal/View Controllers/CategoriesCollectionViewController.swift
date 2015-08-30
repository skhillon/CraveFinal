//
//  CategoriesCollectionViewController.swift
//  Crave App
//
//  Created by Pankaj Khillon on 8/7/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit
import RealmSwift

let reuseIdentifier = "Cell"
let realm = Realm()

class CategoriesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var counter = 0
    
    var selectedCategories: [String] = []
        
    let categoryBank = ["Afghan", "African", "American", "Asian", "Caribbean", "Chinese", "Deli", "Eastern European", "French", "German", "Hawaiian", "Indian", "Indonesian", "Italian", "Mediterranean", "Mexican", "Persian", "Pizza", "Seafood", "Thai"]
    
    let tagImages = ["Afghan.png", "African.png", "American.png", "Asian.png", "Caribbean.png", "Chinese.png", "Deli.png", "EastEuro.png", "French.png", "German.png", "Hawaiian.png", "Indian.png", "Indonesian.png", "Italian.png", "Mediterranean.png", "Mexican.png", "Persian.png", "Pizza.png", "Seafood.png"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("I'M HERE!")
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.allowsMultipleSelection = true
        self.collectionView!.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func segueToHomeScreen() {
        self.performSegueWithIdentifier("segueToHomeScreen", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditSegue" {
            if let destinationVC = segue.destinationViewController as? IngredientSelectionViewController {
                destinationVC.selectedCategories = self.selectedCategories
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryBank.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var category = categoryBank[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryName.text = category

        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 100, height: 50)
    }
    
    func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
         var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionViewCell
         //println(cell)
            if self.counter > 4 {
                println("Error Counter is \(counter)")
                println("Cannot select more than 5 categories")
                let alert = UIAlertController(title: "Oops!", message: "Cannot select more than 5 categories.", preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
                alert.addAction(alertAction)
                presentViewController(alert, animated: true) { () -> Void in }
                //cell.alpha = 1.0
                
            } else {
                self.selectedCategories.append(cell.categoryName.text!)
                counter++
                cell.alpha = 0.5
                println("From selected \(selectedCategories)")

            }
    }

    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionViewCell
        
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
       
        println("From deselected \(selectedCategories)")
        
    }
    
}