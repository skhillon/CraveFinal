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
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var relevantNames: [Name] = []
    var relevantTags: [Tag] = []
    var tags: Tag!
    var names: Name!
    
    struct Choice {
        var name : String
        var color: UIColor
        var isSelected : Bool
    }

    var tag: Tag = Tag()
    var relevantCategoryTags: RealmRelevantCategoryTags = RealmRelevantCategoryTags()
    
    var name: Name = Name()
    var relevantCategoryNames: RealmRelevantCategoryNames = RealmRelevantCategoryNames()
    
    //var currentUser : User = User()
    //var doneButton : UIBarButtonItem?
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    
    //var ingredientsToAppend: [String] = []
    let categoryBank = ["Afghan", "African", "American", "Asian", "Caribbean", "Chinese", "Deli", "EastEuro", "French", "German", "Hawaiian", "Indian", "Indonesian", "Italian", "Mediterranean", "Mexican", "Persian", "Pizza", "Seafood", "Thai"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("I'M HERE!")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        realm.write{
            println("realm write")
            realm.add(self.relevantCategoryTags, update: true)
            realm.add(self.relevantCategoryNames, update: true)
            println(self.relevantCategoryTags)
            println(self.relevantCategoryNames)
        }
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.allowsMultipleSelection = true
        self.collectionView!.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
        //doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "segueToHomeScreen")
        
        // Do any additional setup after loading the view.
        
        if let cvl = collectionViewLayout as? UICollectionViewFlowLayout {
            let widthOfCollectionView = cvl.collectionViewContentSize().width
            cvl.itemSize.width = widthOfCollectionView/2.1
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryBank.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
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
    
    func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
            
            
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.alpha = 0.5
            //categoryBank[indexPath.row]
            //self.navigationItem.rightBarButtonItem = doneButton
            let category = self.categoryBank[indexPath.row]

            switch(category) {
            case "Afghan":
                println("Afghan selected")
                tags = Tag()
                names = Name()
                tags.tag = "503288ae91d4c4b30a586d67"
                relevantTags.append(self.tags)
                name.name = "Afghan"
                relevantNames.append(self.names)
                println(relevantTags[0])
                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                let realmString = RealmString()
//                realmString.string = "Afghan"
//                categoriesSelected.append(realmString)
//                
            case "African":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d1c8941735"
                relevantTags.append(self.tags)
                names.name = "African"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                let catArray = catHolder.componentsSeparatedByString(",")
//                for cat in catArray {
//                    relevantTags.append(cat)
//                }
//                let realmString = RealmString()
//                realmString.string = "African"
//                categoriesSelected.append(realmString)
                
            case "American":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d14e941735"
                relevantTags.append(self.tags)
                names.name = "American"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                let catArray = catHolder.componentsSeparatedByString(",")
//                for cat in catArray {
//                    relevantTags.append(cat)
//                }
//                let realmString = RealmString()
//                realmString.string = "American"
//                categoriesSelected.append(realmString)
                
            case "Asian":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d142941735"
                relevantTags.append(self.tags)
                names.name = "Asian"
                relevantNames.append(self.names)
//                realm.write {
//               self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
               // }
//                let catArray = catHolder.componentsSeparatedByString(",")
//                for cat in catArray {
//                    relevantTags.append(cat)
//                }
//                let realmString = RealmString()
//                realmString.string = "Asian"
//                categoriesSelected.append(realmString)
                
            case "Caribbean":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d144941735"
                relevantTags.append(self.tags)
                names.name = "Caribbean"
                relevantNames.append(self.names)
//                realm.write {
//               self.relevantCategoryNames.relevantNames.append(self.name)
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d144941735")
//                let realmString = RealmString()
//                realmString.string = "Caribbean"
//                categoriesSelected.append(realmString)
                
            case "Chinese":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d145941735"
                relevantTags.append(self.tags)
                names.name = "Chinese"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                let catArray = catHolder.componentsSeparatedByString(",")
//                for cat in catArray {
//                    relevantTags.append(cat)
//                }
//                let realmString = RealmString()
//                realmString.string = "Chinese"
//                categoriesSelected.append(realmString)
                
            case "Deli":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d146941735"
                relevantTags.append(self.tags)
                names.name = "Deli"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//               self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d146941735")
//                let realmString = RealmString()
//                realmString.string = "Deli"
//                categoriesSelected.append(realmString)
                
            case "EastEuro":
                tags = Tag()
                names = Name()
                tags.tag = "52e81612bcbc57f1066b7a01"
                relevantTags.append(self.tags)
                names.name = "EastEuro"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//               self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                let catHolder = "52e81612bcbc57f1066b7a01,5293a7d53cf9994f4e043a45,52f2ae52bcbc57f1066b8b81,4bf58dd8d48988d109941735,52e928d0bcbc57f1066b7e97,52960bac3cf9994f4e043ac4,52e928d0bcbc57f1066b7e98,52e81612bcbc57f1066b7a04,5293a7563cf9994f4e043a44,52e928d0bcbc57f1066b7e9d,52e928d0bcbc57f1066b7e9c,52e928d0bcbc57f1066b7e96,52e928d0bcbc57f1066b7e9a,52e928d0bcbc57f1066b7e9b"
//                let catArray = catHolder.componentsSeparatedByString(",")
//                for cat in catArray {
//                    relevantTags.append(cat)
//                }
//                let realmString = RealmString()
//                realmString.string = "EastEuro"
//                categoriesSelected.append(realmString)
                
            case "French":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d10c941735"
                relevantTags.append(self.tags)
                names.name = "French"
                relevantNames.append(self.names)
//                realm.write {
//               self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("4bf58dd8d48988d10c941735")
//                let realmString = RealmString()
//                realmString.string = "French"
//                categoriesSelected.append(realmString)
                
            case "German":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d10d941735"
                relevantTags.append(self.tags)
                names.name = "German"
                relevantNames.append(self.names)
//                realm.write {
//               self.relevantCategoryNames.relevantNames.append(self.name)
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d10d941735")
//                let realmString = RealmString()
//                realmString.string = "German"
//                categoriesSelected.append(realmString)
                
            case "Hawaiian":
                tags = Tag()
                names = Name()
                tags.tag = "52e81612bcbc57f1066b79fe"
                relevantTags.append(self.tags)
                names.name = "Hawaiian"
                relevantNames.append(self.names)
//                realm.write {
//               self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("52e81612bcbc57f1066b79fe")
//                let realmString = RealmString()
//                realmString.string = "Hawaiian"
//                categoriesSelected.append(realmString)
//                
            case "Indian":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d10f941735"
                relevantTags.append(self.tags)
                names.name = "Indian"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("4bf58dd8d48988d10f941735")
//                let realmString = RealmString()
//                realmString.string = "Indian"
//                categoriesSelected.append(realmString)
                
            case "Indonesian":
                tags = Tag()
                names = Name()
                tags.tag = "52960eda3cf9994f4e043ac9"
                relevantTags.append(self.tags)
                names.name = "Indonesian"
                relevantNames.append(self.names)
//                realm.write {
//               self.relevantCategoryTags.relevantTags.append(self.tag)
//               self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("52960eda3cf9994f4e043ac9")
//                let realmString = RealmString()
//                realmString.string = "Indonesian"
//                categoriesSelected.append(realmString)
                
            case "Italian":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d110941735"
                relevantTags.append(self.tags)
                names.name = "Italian"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//               self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d110941735")
//                let realmString = RealmString()
//                realmString.string = "Italian"
//                categoriesSelected.append(realmString)
                
            case "Mediterranean":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d1c0941735"
                relevantTags.append(self.tags)
                names.name = "Mediterranean"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("4bf58dd8d48988d1c0941735,4bf58dd8d48988d1c3941735")
//                let realmString = RealmString()
//                realmString.string = "Mediterranean"
//                categoriesSelected.append(realmString)
                
            case "Mexican":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d1c1941735"
                relevantTags.append(self.tags)
                names.name = "Mexican"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d1c1941735")
//                let realmString = RealmString()
//                realmString.string = "Mexican"
//                categoriesSelected.append(realmString)
                
            case "Persian":
                tags = Tag()
                names = Name()
                tags.tag = "52e81612bcbc57f1066b79f7"
                relevantTags.append(self.tags)
                names.name = "Persian"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("52e81612bcbc57f1066b79f7")
//                let realmString = RealmString()
//                realmString.string = "Persian"
//                categoriesSelected.append(realmString)
                
            case "Pizza":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d1ca941735"
                relevantTags.append(self.tags)
                names.name = "Pizza"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d1ca941735")
//                let realmString = RealmString()
//                realmString.string = "Pizza"
//                categoriesSelected.append(realmString)
                
            case "Seafood":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d1d2941735"
                relevantTags.append(self.tags)
                names.name = "Seafood"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                }
//                relevantTags.append("4bf58dd8d48988d1d2941735,4edd64a0c7ddd24ca188df1a")
//                let realmString = RealmString()
//                realmString.string = "Seafood"
//                categoriesSelected.append(realmString)

            case "Thai":
                tags = Tag()
                names = Name()
                tags.tag = "4bf58dd8d48988d149941735"
                relevantTags.append(self.tags)
                names.name = "Thai"
                relevantNames.append(self.names)
//                realm.write {
//                    self.relevantCategoryNames.relevantNames.append(self.name)
//                    self.relevantCategoryTags.relevantTags.append(self.tag)
//                }
//                relevantTags.append("4bf58dd8d48988d149941735")
//                let realmString = RealmString()
//                realmString.string = "Thai"
//                categoriesSelected.append(realmString)
//                
            default:
                println("No categories appended")
                
            }
            

            realm.write {
                for tag in self.relevantTags {
                    self.relevantCategoryTags.relevantTags.append(tag)
                }
                realm.add(self.relevantCategoryTags)
                
                for name in self.relevantNames {
                    self.relevantCategoryNames.relevantNames.append(name)
                }
                realm.add(self.relevantCategoryNames)
            }
            
//            var currentUser = User()
//            currentUser.relevantCategories = self.categoriesSelected
            
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        relevantCategoryNames.relevantNames.removeAtIndex(index)
    }
    
}