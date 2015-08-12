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

class CategoriesCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    struct Choice {
        var name : String
        var color: UIColor
        var isSelected : Bool
    }
    

    var currentUser : User = User()
    var doneButton : UIBarButtonItem?
    
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var categoriesSelected: List<RealmString> = List<RealmString>()
    var relevantTags: [String] = []
    var ingredientsToAppend: [String] = []
    let categoryBank = ["Afghan", "African", "American", "Asian", "Caribbean", "Chinese", "Deli", "EastEuro", "French", "German", "Hawaiian", "Indian", "Indonesian", "Italian", "Mediterranean", "Mexican", "Persian", "Pizza", "Seafood", "Thai"]
    
    convenience init() {
        self.init()
        var categoryNames = self.categoriesSelected
        var categoryTags = self.relevantTags
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.allowsMultipleSelection = true
        self.collectionView!.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
        doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "segueToHomeScreen")
        
        // Do any additional setup after loading the view.
        
        if let cvl = collectionViewLayout as? UICollectionViewFlowLayout {
            let widthOfCollectionView = cvl.collectionViewContentSize().width
            cvl.itemSize.width = widthOfCollectionView/2.1
        }
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        //don't think you need this, since you're going through multiple functions
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryBank.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var category = categoryBank[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell

        //cell.tintColor = UIColor()
        
//        if(Choice.isSelected) {
//            cell.alpha = 0.5
//        }
//        else {
//            //cell.alpha = 1
//        }
        
//        cell.categoryName.text = Choice.name
//        cell.categoryImage.image = Choice.image
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 120, height: 120)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.alpha = 0.5
            categoryBank[indexPath.row]
            self.navigationItem.rightBarButtonItem = doneButton
            let category = self.categoryBank[indexPath.row]
            
            
            switch(category) {
            case "Afghan":
                relevantTags.append("503288ae91d4c4b30a586d67")
                let realmString = RealmString()
                realmString.string = "Afghan"
                categoriesSelected.append(realmString)
                
            case "African":
                let catHolder = "4bf58dd8d48988d1c8941735"
                let catArray = catHolder.componentsSeparatedByString(",")
                for cat in catArray {
                    relevantTags.append(cat)
                }
                let realmString = RealmString()
                realmString.string = "African"
                categoriesSelected.append(realmString)
                
            case "American":
                let catHolder = "4bf58dd8d48988d14e941735"
                let catArray = catHolder.componentsSeparatedByString(",")
                for cat in catArray {
                    relevantTags.append(cat)
                }
                let realmString = RealmString()
                realmString.string = "American"
                categoriesSelected.append(realmString)
                
            case "Asian":
                let catHolder = "4bf58dd8d48988d142941735"
                let catArray = catHolder.componentsSeparatedByString(",")
                for cat in catArray {
                    relevantTags.append(cat)
                }
                let realmString = RealmString()
                realmString.string = "Asian"
                categoriesSelected.append(realmString)
                
            case "Caribbean":
                relevantTags.append("4bf58dd8d48988d144941735")
                let realmString = RealmString()
                realmString.string = "Caribbean"
                categoriesSelected.append(realmString)
                
            case "Chinese":
                let catHolder = "4bf58dd8d48988d145941735"
                let catArray = catHolder.componentsSeparatedByString(",")
                for cat in catArray {
                    relevantTags.append(cat)
                }
                let realmString = RealmString()
                realmString.string = "Chinese"
                categoriesSelected.append(realmString)
                
            case "Deli":
                relevantTags.append("4bf58dd8d48988d146941735")
                let realmString = RealmString()
                realmString.string = "Deli"
                categoriesSelected.append(realmString)
                
            case "EastEuro":
                let catHolder = "52e81612bcbc57f1066b7a01,5293a7d53cf9994f4e043a45,52f2ae52bcbc57f1066b8b81,4bf58dd8d48988d109941735,52e928d0bcbc57f1066b7e97,52960bac3cf9994f4e043ac4,52e928d0bcbc57f1066b7e98,52e81612bcbc57f1066b7a04,5293a7563cf9994f4e043a44,52e928d0bcbc57f1066b7e9d,52e928d0bcbc57f1066b7e9c,52e928d0bcbc57f1066b7e96,52e928d0bcbc57f1066b7e9a,52e928d0bcbc57f1066b7e9b"
                let catArray = catHolder.componentsSeparatedByString(",")
                for cat in catArray {
                    relevantTags.append(cat)
                }
                let realmString = RealmString()
                realmString.string = "EastEuro"
                categoriesSelected.append(realmString)
                
            case "French":
                relevantTags.append("4bf58dd8d48988d10c941735")
                let realmString = RealmString()
                realmString.string = "French"
                categoriesSelected.append(realmString)
                
            case "German":
                relevantTags.append("4bf58dd8d48988d10d941735")
                let realmString = RealmString()
                realmString.string = "German"
                categoriesSelected.append(realmString)
                
            case "Hawaiian":
                relevantTags.append("52e81612bcbc57f1066b79fe")
                let realmString = RealmString()
                realmString.string = "Hawaiian"
                categoriesSelected.append(realmString)
                
            case "Indian":
                relevantTags.append("4bf58dd8d48988d10f941735")
                let realmString = RealmString()
                realmString.string = "Indian"
                categoriesSelected.append(realmString)
                
            case "Indonesian":
                relevantTags.append("52960eda3cf9994f4e043ac9")
                let realmString = RealmString()
                realmString.string = "Indonesian"
                categoriesSelected.append(realmString)
                
            case "Italian":
                relevantTags.append("4bf58dd8d48988d110941735")
                let realmString = RealmString()
                realmString.string = "Italian"
                categoriesSelected.append(realmString)
                
            case "Mediterranean":
                relevantTags.append("4bf58dd8d48988d1c0941735,4bf58dd8d48988d1c3941735")
                let realmString = RealmString()
                realmString.string = "Mediterranean"
                categoriesSelected.append(realmString)
                
            case "Mexican":
                relevantTags.append("4bf58dd8d48988d1c1941735")
                let realmString = RealmString()
                realmString.string = "Mexican"
                categoriesSelected.append(realmString)
                
            case "Persian":
                relevantTags.append("52e81612bcbc57f1066b79f7")
                let realmString = RealmString()
                realmString.string = "Persian"
                categoriesSelected.append(realmString)
                
            case "Pizza":
                relevantTags.append("4bf58dd8d48988d1ca941735")
                let realmString = RealmString()
                realmString.string = "Pizza"
                categoriesSelected.append(realmString)
                
            case "Seafood":
                relevantTags.append("4bf58dd8d48988d1d2941735,4edd64a0c7ddd24ca188df1a")
                let realmString = RealmString()
                realmString.string = "Seafood"
                categoriesSelected.append(realmString)

            case "Thai":
                relevantTags.append("4bf58dd8d48988d149941735")
                let realmString = RealmString()
                realmString.string = "Thai"
                categoriesSelected.append(realmString)
                
            default:
                println("No categories appended")
                
            }
            
            var currentUser = User()
            currentUser.relevantCategories = self.categoriesSelected
            
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let category = categoryBank[indexPath.row]
        
        categoriesSelected.removeAtIndex(indexPath.row)
    }
    
}