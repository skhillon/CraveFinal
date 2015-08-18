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
    @IBOutlet weak var iconImage: UIImage!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var counter = 0
    
    var relevantNames: [Name] = []
    var relevantTags: [Tag] = []
    var relevantIngredients: [Ingredient] = []
    var tags: Tag!
    var names: Name!
    var ingredients: Ingredient!
    
    struct Choice {
        var name : String
        var color: UIColor
        var isSelected : Bool
    }

    var relevantCategoryTags: RealmRelevantCategoryTags = RealmRelevantCategoryTags()
    
    var relevantCategoryNames: RealmRelevantCategoryNames = RealmRelevantCategoryNames()
    
    var relevantIngredientsLiked: RealmIngredientLiked = RealmIngredientLiked()
    
    //var doneButton : UIBarButtonItem?
    //let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    //var ingredientsToAppend: [String] = []
    let categoryBank = ["Afghan", "African", "American", "Asian", "Caribbean", "Chinese", "Deli", "EastEuro", "French", "German", "Hawaiian", "Indian", "Indonesian", "Italian", "Mediterranean", "Mexican", "Persian", "Pizza", "Seafood", "Thai"]
    
    let tagImages = ["Afghan.png", "African.png", "American.png", "Asian.png", "Caribbean.png", "Chinese.png", "Deli.png", "EastEuro.png", "French.png", "German.png", "Hawaiian.png", "Indian.png", "Indonesian.png", "Italian.png", "Mediterranean.png", "Mexican.png", "Persian.png", "Pizza.png", "Seafood.png"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        println("I'M HERE!")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        realm.write{
            println("realm write")
            realm.add(self.relevantCategoryTags, update: true)
            realm.add(self.relevantCategoryNames, update: true)
            realm.add(self.relevantIngredientsLiked, update: true)
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
        
        //cell.categoryName.text = category
        //cell.iconImage.images = UIImage(named: tagImages[indexPath.row])

        //cell.tintColor = UIColor()
        
//        if(Choice.isSelected) {
//            cell.alpha = 0.5
//        }
//        else {
//            //cell.alpha = 1
//        }
        
       //cell.categoryName.text = categoryBank[indexPath.row]
       // cell.iconImage = UIImage(contentsOfFile: categoryBank[indexPath.row])
    
//        cell.categoryImage.image = Choice.image
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 120, height: 120)
    }
    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//            return sectionInsets
//    }
    func createRealm(tagData: String, nameData: String, ingredientsArray: [String]) {
        tags = Tag()
        names = Name()
        ingredients = Ingredient()
        tags.tag = tagData
        relevantTags.append(self.tags)
        names.name = nameData
        relevantNames.append(self.names)
        
        let arr: [String] = ingredientsArray
        var arrList: List<RealmString> = List<RealmString>()
        for a in arr {
            let realmA = RealmString()
            realmA.string = a
            println(realmA)
            arrList.append(realmA)
            
        }
        
        
        ingredients.ingredient = arrList
        
        
        realm.write {
            self.relevantCategoryTags.relevantTags.append(self.tags)
            realm.add(self.relevantCategoryTags)
            
            self.relevantCategoryNames.relevantNames.append(self.names)
            realm.add(self.relevantCategoryNames)
            
            self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
            realm.add(self.relevantIngredientsLiked)
            
        }

    }
    
    
    func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
            
            
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            cell?.alpha = 0.5
            
            if self.counter < 5 {
            //categoryBank[indexPath.row]
            //self.navigationItem.rightBarButtonItem = doneButton
            let category = self.categoryBank[indexPath.row]

            switch(category) {
            case "Afghan":
                println("Afghan selected")
                
//                let arr: [String] = ["onions", "lamb", "rice", "lentils", "bolani", "mantwo", "aushak", "kabob"]
                let arr: [String] = ["lentils", "chickpeas", "cardamom", "chili", "cinnamon", "coriander", "cumin", "masala", "ginger", "mustard seed", "onion", "garlic", "turmeric", "rice", "cheese", "chicken", "beans"]
                
                createRealm("4bf58dd8d48988d10f941735", nameData: "Indian", ingredientsArray: arr)
                
                counter++

            case "African":
                counter++
                let arr: [String] = ["corn", "fennel", "miele", "carrot", "scallion", "chicken", "ginger", "garlic", "olive oil", "cumin", "turmeric"]
                createRealm("4bf58dd8d48988d1c8941735", nameData: "African", ingredientsArray: arr)
        
                
            case "American":
                counter++
                let arr: [String] = ["cheese", "chicken", "beef", "onion", "salt", "pepper", "soup", "pasta", "oil", "garlic", "tomato", "sauce", "butter", "milk", "potatoes", "corn"]
                createRealm("4bf58dd8d48988d14e941735", nameData: "American", ingredientsArray: arr)
                
            case "Asian":
                counter++
                let arr: [String] = ["soy", "sauce", "rice", "vinegar", "fish", "sriracha", "oyster", "coconut", "curry", "miso", "paste", "sesame", "oil", "sake", "rice", "noodles", "ginger", "lime", "cilantro"]
                createRealm("4bf58dd8d48988d142941735", nameData: "Asian", ingredientsArray: arr)
                
            
            case "Caribbean":
                counter++
                let arr: [String] = ["allspice", "callaloo", "coconut", "molasses", "pigeon", "peas", "pepper", "plantains", "rum", "scotch", "chiles", "turmeric"]
                createRealm("4bf58dd8d48988d144941735", nameData: "Caribbean", ingredientsArray: arr)
                
                
//            case "Chinese":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d145941735"
//                relevantTags.append(self.tags)
//                names.name = "Chinese"
//                relevantNames.append(self.names)
//                
//                    let arr: [String] = ["bamboo shoots", "bean", "chile", "noodles", "sticky", "rice", "jasmine", "shiitake", "sichuan", "soy", "sesame ", "water", "chestnuts"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                let catArray = catHolder.componentsSeparatedByString(",")
////                for cat in catArray {
////                    relevantTags.append(cat)
////                }
////                let realmString = RealmString()
////                realmString.string = "Chinese"
////                categoriesSelected.append(realmString)
//                
//            case "Deli":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d146941735"
//                relevantTags.append(self.tags)
//                names.name = "Deli"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["cold", "cuts", "salad", "pasta", "potato", "chicken", "tuna", "shrimp", "cheese", "eggplant", "pastrami", "roast beef", "salami", "ham", "turkey", "bologna"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                    println(a)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////               self.relevantCategoryTags.relevantTags.append(self.tag)
////                }
////                relevantTags.append("4bf58dd8d48988d146941735")
////                let realmString = RealmString()
////                realmString.string = "Deli"
////                categoriesSelected.append(realmString)
//                
//            case "EastEuro":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "52e81612bcbc57f1066b7a01"
//                relevantTags.append(self.tags)
//                names.name = "EastEuro"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["curd", "cheese", "kohlrabi", "peperivka", "kovbasa", "sorrel", "squash", "vegeta"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////               self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                let catHolder = "52e81612bcbc57f1066b7a01,5293a7d53cf9994f4e043a45,52f2ae52bcbc57f1066b8b81,4bf58dd8d48988d109941735,52e928d0bcbc57f1066b7e97,52960bac3cf9994f4e043ac4,52e928d0bcbc57f1066b7e98,52e81612bcbc57f1066b7a04,5293a7563cf9994f4e043a44,52e928d0bcbc57f1066b7e9d,52e928d0bcbc57f1066b7e9c,52e928d0bcbc57f1066b7e96,52e928d0bcbc57f1066b7e9a,52e928d0bcbc57f1066b7e9b"
////                let catArray = catHolder.componentsSeparatedByString(",")
////                for cat in catArray {
////                    relevantTags.append(cat)
////                }
////                let realmString = RealmString()
////                realmString.string = "EastEuro"
////                categoriesSelected.append(realmString)
//                
//            case "French":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d10c941735"
//                relevantTags.append(self.tags)
//                names.name = "French"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["baguette", "butter", "cheese", "fleur", "herbes", "provence", "leeks", "mustard", "olive oil", "shallots", "tarragon", "chicken", "vinegar", "wine"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////               self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("4bf58dd8d48988d10c941735")
////                let realmString = RealmString()
////                realmString.string = "French"
////                categoriesSelected.append(realmString)
//                
//            case "German":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d10d941735"
//                relevantTags.append(self.tags)
//                names.name = "German"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["pork", "beef", "chicken", "duck", "goose", "prunes", "apples", "venison", "boar", "hare", "pheasant", "trout", "potato", "dumplings", "cabbage", "carrots", "radishes", "turnips", "asparagus"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////               self.relevantCategoryNames.relevantNames.append(self.name)
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                }
////                relevantTags.append("4bf58dd8d48988d10d941735")
////                let realmString = RealmString()
////                realmString.string = "German"
////                categoriesSelected.append(realmString)
//                
//            case "Hawaiian":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "52e81612bcbc57f1066b79fe"
//                relevantTags.append(self.tags)
//                names.name = "Hawaiian"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["taro", "sweet potato", "purple yam", "breadfruit", "sea", "mineral", "ti", "hala", "limpets", "kukui", "imu", "beef", "pork", "chicken", "butterfish", "soy sauce", "sesame oil", "coconut milk", "squid", "cornstarch"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
//                
////                realm.write {
////               self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("52e81612bcbc57f1066b79fe")
////                let realmString = RealmString()
////                realmString.string = "Hawaiian"
////                categoriesSelected.append(realmString)
////                
//            case "Indian":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d10f941735"
//                relevantTags.append(self.tags)
//                names.name = "Indian"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["lentils", "chickpeas", "cardamom", "chili", "cinnamon", "coriander", "cumin", "masala", "ginger", "mustard seed", "onion", "garlic", "turmeric", "rice", "cheese", "chicken", "beans"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("4bf58dd8d48988d10f941735")
////                let realmString = RealmString()
////                realmString.string = "Indian"
////                categoriesSelected.append(realmString)
//                
//            case "Indonesian":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "52960eda3cf9994f4e043ac9"
//                relevantTags.append(self.tags)
//                names.name = "Indonesian"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["rice", "coconut", "turmeric", "wheat", "noodles", "bakpao", "cakwe", "yam", "sweet", "potato", "taro", "cassava", "maize", "breadfruit", "jackfruit", "spinach", "papaya", "cassava", "cabbage", "potato", "carrot", "beef", "chicken", "duck", "goat", "lamb"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
//                
////                realm.write {
////               self.relevantCategoryTags.relevantTags.append(self.tag)
////               self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("52960eda3cf9994f4e043ac9")
////                let realmString = RealmString()
////                realmString.string = "Indonesian"
////                categoriesSelected.append(realmString)
//                
//            case "Italian":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d110941735"
//                relevantTags.append(self.tags)
//                names.name = "Italian"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["tomatoes", "pasta", "rice", "flour", "beans", "bread", "artichoke", "olives", "olive oil", "garlic", "prosciutto", "basil", "mozzarella", "balsamic", "wine", "marsala", "parmesan"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////               self.relevantCategoryTags.relevantTags.append(self.tag)
////                }
////                relevantTags.append("4bf58dd8d48988d110941735")
////                let realmString = RealmString()
////                realmString.string = "Italian"
////                categoriesSelected.append(realmString)
//                
//            case "Mediterranean":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d1c0941735"
//                relevantTags.append(self.tags)
//                names.name = "Mediterranean"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["olive oil", "lamb", "onions", "pepper", "tomato", "phyllo", "spinach", "feta", "cheese", "hummus", "chickpeas", "garlic", "eggplant", "cinnamon", "grape", "rice", "chicken", "beef", "tahini"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
//                
////                realm.write {
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("4bf58dd8d48988d1c0941735,4bf58dd8d48988d1c3941735")
////                let realmString = RealmString()
////                realmString.string = "Mediterranean"
////                categoriesSelected.append(realmString)
//                
//            case "Mexican":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d1c1941735"
//                relevantTags.append(self.tags)
//                names.name = "Mexican"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["avocadoes", "beans", "cheese", "chipotle", "chocolate", "sour", "cream", "lime", "oregano", "poblanos", "tomatoes", "tortilla", "salsa"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                }
////                relevantTags.append("4bf58dd8d48988d1c1941735")
////                let realmString = RealmString()
////                realmString.string = "Mexican"
////                categoriesSelected.append(realmString)
//                
//            case "Persian":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "52e81612bcbc57f1066b79f7"
//                relevantTags.append(self.tags)
//                names.name = "Persian"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["garbanzo beans", "onion", "garlic cloves", "garlic", "parsley", "flour", "salt", "cumin", "coriander", "cardamom", "fava beans", "chickpeas", "pita bread"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("52e81612bcbc57f1066b79f7")
////                let realmString = RealmString()
////                realmString.string = "Persian"
////                categoriesSelected.append(realmString)
//                
//            case "Pizza":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d1ca941735"
//                relevantTags.append(self.tags)
//                names.name = "Pizza"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["wheat", "flour", "dough", "tomato", "garlic", "onion", "basil", "pepperoni", "bacon", "beef", "chicken", "italian", "sausage", "breast", "salami", "ham", "cheese", "ranch", "marinara"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
//                
////                realm.write {
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                }
////                relevantTags.append("4bf58dd8d48988d1ca941735")
////                let realmString = RealmString()
////                realmString.string = "Pizza"
////                categoriesSelected.append(realmString)
//                
//            case "Seafood":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d1d2941735"
//                relevantTags.append(self.tags)
//                names.name = "Seafood"
//                relevantNames.append(self.names)
//                
//                let arr: [String] = ["shrimp", "tuna", "shellfish", "shark", "salmon", "sushi", "squid", "fish", "fillet", "cod", "mackerel", "anchovies"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
////                realm.write {
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                }
////                relevantTags.append("4bf58dd8d48988d1d2941735,4edd64a0c7ddd24ca188df1a")
////                let realmString = RealmString()
////                realmString.string = "Seafood"
////                categoriesSelected.append(realmString)
//
//            case "Thai":
//                counter++
//                tags = Tag()
//                names = Name()
//                ingredients = Ingredient()
//                tags.tag = "4bf58dd8d48988d149941735"
//                relevantTags.append(self.tags)
//                names.name = "Thai"
//                relevantNames.append(self.names)
//
//                let arr: [String] = ["fish", "sauce", "nam", "pla", "anchovies", "cilantro", "basil", "coriander", "chile", "coconut", "milk", "palm", "lemongrass", "bamboo", "beancurd", "beansprouts"]
//                
//                for a in arr {
//                    ingredients.ingredient = a
//                    relevantIngredients.append(self.ingredients)
//                }
//                
//                realm.write {
//                    self.relevantCategoryTags.relevantTags.append(self.tags)
//                    realm.add(self.relevantCategoryTags)
//                    
//                    self.relevantCategoryNames.relevantNames.append(self.names)
//                    realm.add(self.relevantCategoryNames)
//                    
//                    self.relevantIngredientsLiked.ingredientsLiked.append(self.ingredients)
//                    realm.add(self.relevantIngredientsLiked)
//                }
//                
////                realm.write {
////                    self.relevantCategoryNames.relevantNames.append(self.name)
////                    self.relevantCategoryTags.relevantTags.append(self.tag)
////                }
////                relevantTags.append("4bf58dd8d48988d149941735")
////                let realmString = RealmString()
////                realmString.string = "Thai"
////                categoriesSelected.append(realmString)
////                
//            default:
//                println("No categories appended")
//                
//            }
//            
////
////            realm.write {
////                
////                for name in self.relevantNames {
////                    self.relevantCategoryNames.relevantNames.append(name)
////                }
////                realm.add(self.relevantCategoryNames)
////                
////                for ing in self.relevantIngredients {
////                    self.relevantIngredientsLiked.ingredientsLiked.append(ing)
////                }
////                realm.add(self.relevantIngredientsLiked)
////            }
//            
////            var currentUser = User()
////            currentUser.relevantCategories = self.categoriesSelected
            default:
                println("fail")
                }
            } else {
                println("Cannot select more than 5 categories")
                let alert = UIAlertController(title: "Oops!", message: "Cannot select more than 5 categories.", preferredStyle: UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
                alert.addAction(alertAction)
                presentViewController(alert, animated: true) { () -> Void in }
            }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionViewCell
        cell.alpha = 1.0
        realm.write {
            self.relevantCategoryNames.relevantNames.removeAtIndex(index)
            self.relevantCategoryTags.relevantTags.removeAtIndex(index)
            self.relevantIngredientsLiked.ingredientsLiked.removeAtIndex(index)
        }
        counter--
    }
    
}