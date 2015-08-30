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
    
//    var relevantNames: [Name] = []
//    var relevantTags: [Tag] = []
//    var relevantIngredients: [Ingredient] = []
//    var tags: Tag!
//    var names: Name!
//    var ingredients: Ingredient!
//    
//    struct Choice {
//        var name : String
//        var color: UIColor
//        var isSelected : Bool
//    }
// 
//    var relevantCategoryTags: RealmRelevantCategoryTags = RealmRelevantCategoryTags()
//    
//    var relevantCategoryNames: RealmRelevantCategoryNames = RealmRelevantCategoryNames()
//    
//    var relevantIngredientsLiked: RealmIngredientLiked = RealmIngredientLiked()
    
    //var categoriesToEdit: [String] = []
    //var categoriesDictionary: [String: [String]] = [:]
    
        
    let categoryBank = ["Afghan", "African", "American", "Asian", "Caribbean", "Chinese", "Deli", "Eastern European", "French", "German", "Hawaiian", "Indian", "Indonesian", "Italian", "Mediterranean", "Mexican", "Persian", "Pizza", "Seafood", "Thai"]
    
    let tagImages = ["Afghan.png", "African.png", "American.png", "Asian.png", "Caribbean.png", "Chinese.png", "Deli.png", "EastEuro.png", "French.png", "German.png", "Hawaiian.png", "Indian.png", "Indonesian.png", "Italian.png", "Mediterranean.png", "Mexican.png", "Persian.png", "Pizza.png", "Seafood.png"]
    
//    var mealCategories: [MealCollection?] = []
//    
//    func loadMealCategories() {
//        for (var i = 0; i < categoryBank.count; i++) {
//            let catLabel: String = categoryBank[i]
//           // let tagImage: UIImage = UIImage(named: tagImages[i])!
//            
//            let mealCollection = MealCollection(name: catLabel/*, icon: tagImage*/)
//            self.mealCategories.append(mealCollection!)
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.loadMealCategories()
        
        println("I'M HERE!")
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.allowsMultipleSelection = true
        self.collectionView!.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
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
         println(cell)
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
        //let indexToRemove = selectedIngredients.find("\(cell.nameIng.text!)")
        
        var found: Int?  // <= will hold the index if it was found, or else will be nil
        for i in (0...(selectedCategories.count - 1)) {
            if selectedCategories[i] == "\(cell.categoryName.text!)" {
                found = i
            }
        }
        self.selectedCategories.removeAtIndex(found!)
        cell.alpha = 1.0
        counter--
        println("From deselected \(selectedCategories)")
        
    }
    
}
    
//            let category = self.categoryBank[indexPath.row]
//
//            switch(category) {
//            case "Afghan":
//                println("Afghan selected")
//                
//                let arr: [String] = ["onions", "lamb", "rice", "lentils", "bolani", "mantwo", "aushak", "kabob"]
//                
//                createRealm("4bf58dd8d48988d10f941735", nameData: "Afghan", ingredientsArray: arr)
//                
//                counter++
//                
//            case "African":
//                println("African selected")
//
//                let arr: [String] = ["corn", "fennel", "miele", "carrot", "scallion", "chicken", "ginger", "garlic", "olive oil", "cumin", "turmeric"]
//                createRealm("4bf58dd8d48988d1c8941735", nameData: "African", ingredientsArray: arr)
//                counter++
//
//        
//                
//            case "American":
//                println("American selected")
//
//                let arr: [String] = ["cheese", "chicken", "beef", "onion", "salt", "pepper", "soup", "pasta", "oil", "garlic", "tomato", "sauce", "butter", "milk", "potatoes", "corn"]
//                createRealm("4bf58dd8d48988d14e941735", nameData: "American", ingredientsArray: arr)
//                counter++
//
//                
//            case "Asian":
//                println("Asian selected")
//
//                let arr: [String] = ["soy", "sauce", "rice", "vinegar", "fish", "sriracha", "oyster", "coconut", "curry", "miso", "paste", "sesame", "oil", "sake", "rice", "noodles", "ginger", "lime", "cilantro"]
//                createRealm("4bf58dd8d48988d142941735", nameData: "Asian", ingredientsArray: arr)
//                counter++
//
//                
//            
//            case "Caribbean":
//                println("Caribbean selected")
//
//                let arr: [String] = ["allspice", "callaloo", "coconut", "molasses", "pigeon", "peas", "pepper", "plantains", "rum", "scotch", "chiles", "turmeric"]
//                createRealm("4bf58dd8d48988d144941735", nameData: "Caribbean", ingredientsArray: arr)
//                counter++
//
//
//                
//            case "Chinese":
//                println("Chinese selected")
//                
//                let arr: [String] = ["bamboo shoots", "bean", "chile", "noodles", "sticky", "rice", "jasmine", "shiitake", "sichuan", "soy", "sesame ", "water", "chestnuts"]
//
//                createRealm("4bf58dd8d48988d146941735", nameData: "Caribbean", ingredientsArray: arr)
//                counter++
//
//
//                //fix this below
//            case "Deli":
//                println("Deli selected")
//                let arr: [String] = ["cold", "cuts", "salad", "pasta", "potato", "chicken", "tuna", "shrimp", "cheese", "eggplant", "pastrami", "roast beef", "salami", "ham", "turkey", "bologna"]
//                
//                createRealm("4bf58dd8d48988d146941735", nameData: "Deli", ingredientsArray: arr)
//                counter++
//
//                
//                
//            case "Eastern European":
//                println("Eastern European selected")
//                
//                let arr: [String] = ["curd", "cheese", "kohlrabi", "peperivka", "kovbasa", "sorrel", "squash", "vegeta"]
//                
//                createRealm("52e81612bcbc57f1066b7a01", nameData: "Eastern European", ingredientsArray: arr)
//                counter++
//
//                
//            case "French":
//                println("French selected")
//                
//                let arr: [String] = ["baguette", "butter", "cheese", "fleur", "herbes", "provence", "leeks", "mustard", "olive oil", "shallots", "tarragon", "chicken", "vinegar", "wine"]
//
//                createRealm("4bf58dd8d48988d10c941735", nameData: "French", ingredientsArray: arr)
//                counter++
//
//
//            case "German":
//                println("German selected")
//                
//                let arr: [String] = ["pork", "beef", "chicken", "duck", "goose", "prunes", "apples", "venison", "boar", "hare", "pheasant", "trout", "potato", "dumplings", "cabbage", "carrots", "radishes", "turnips", "asparagus"]
//
//                createRealm("4bf58dd8d48988d10d941735", nameData: "German", ingredientsArray: arr)
//                counter++
//
//
//            case "Hawaiian":
//                println("Hawaiian selected")
//                
//                let arr: [String] = ["taro", "sweet potato", "purple yam", "breadfruit", "sea", "mineral", "ti", "hala", "limpets", "kukui", "imu", "beef", "pork", "chicken", "butterfish", "soy sauce", "sesame oil", "coconut milk", "squid", "cornstarch"]
//
//                createRealm("52e81612bcbc57f1066b79fe", nameData: "Hawaiian", ingredientsArray: arr)
//                counter++
//
//
//                
//            case "Indian":
//                println("Indian selected")
//                
//                let arr: [String] = ["lentils", "chickpeas", "cardamom", "chili", "cinnamon", "coriander", "cumin", "masala", "ginger", "mustard seed", "onion", "garlic", "turmeric", "rice", "cheese", "chicken", "beans"]
//
//                createRealm("4bf58dd8d48988d10f941735", nameData: "Indian", ingredientsArray: arr)
//                counter++
//
//
//                
//            case "Indonesian":
//                println("Indonesian selected")
//                
//                let arr: [String] = ["rice", "coconut", "turmeric", "wheat", "noodles", "bakpao", "cakwe", "yam", "sweet", "potato", "taro", "cassava", "maize", "breadfruit", "jackfruit", "spinach", "papaya", "cassava", "cabbage", "potato", "carrot", "beef", "chicken", "duck", "goat", "lamb"]
//                
//
//                createRealm("52960eda3cf9994f4e043ac9", nameData: "Indonesian", ingredientsArray: arr)
//                counter++
//
//
//            case "Italian":
//                println("Italian selected")
//                
//                let arr: [String] = ["tomatoes", "pasta", "rice", "flour", "beans", "bread", "artichoke", "olives", "olive oil", "garlic", "prosciutto", "basil", "mozzarella", "balsamic", "wine", "marsala", "parmesan"]
//
//                createRealm("4bf58dd8d48988d110941735", nameData: "Italian", ingredientsArray: arr)
//                counter++
//
//                
//            case "Mediterranean":
//                println("Mediterranean selected")
//                
//                let arr: [String] = ["olive oil", "lamb", "onions", "pepper", "tomato", "phyllo", "spinach", "feta", "cheese", "hummus", "chickpeas", "garlic", "eggplant", "cinnamon", "grape", "rice", "chicken", "beef", "tahini"]
//
//                createRealm("4bf58dd8d48988d1c0941735", nameData: "Mediterranean", ingredientsArray: arr)
//                counter++
//
//                
//            case "Mexican":
//                println("Mexican selected")
//                
//                let arr: [String] = ["avocadoes", "beans", "cheese", "chipotle", "chocolate", "sour", "cream", "lime", "oregano", "poblanos", "tomatoes", "tortilla", "salsa"]
//
//                createRealm("4bf58dd8d48988d1c1941735", nameData: "Mexican", ingredientsArray: arr)
//                counter++
//
//
//            case "Persian":
//                println("Persian selected")
//                
//                let arr: [String] = ["garbanzo beans", "onion", "garlic cloves", "garlic", "parsley", "flour", "salt", "cumin", "coriander", "cardamom", "fava beans", "chickpeas", "pita bread"]
//
//                createRealm("52e81612bcbc57f1066b79f7", nameData: "Persian", ingredientsArray: arr)
//                counter++
//
//
//                
//            case "Pizza":
//                println("Pizza selected")
//                
//                let arr: [String] = ["wheat", "flour", "dough", "tomato", "garlic", "onion", "basil", "pepperoni", "bacon", "beef", "chicken", "italian", "sausage", "breast", "salami", "ham", "cheese", "ranch", "marinara"]
//
//                createRealm("4bf58dd8d48988d1ca941735", nameData: "Pizza", ingredientsArray: arr)
//                counter++
//
//                
//            case "Seafood":
//                println("Seafood selected")
//                
//                let arr: [String] = ["shrimp", "tuna", "shellfish", "shark", "salmon", "sushi", "squid", "fish", "fillet", "cod", "mackerel", "anchovies"]
//
//                createRealm("4bf58dd8d48988d1d2941735", nameData: "Seafood", ingredientsArray: arr)
//                counter++
//
//                
//            case "Thai":
//                println("Thai selected")
//                
//                let arr: [String] = ["fish", "sauce", "nam", "pla", "anchovies", "cilantro", "basil", "coriander", "chile", "coconut", "milk", "palm", "lemongrass", "bamboo", "beancurd", "beansprouts"]
//                
//                createRealm("4bf58dd8d48988d149941735", nameData: "Thai", ingredientsArray: arr)
//                counter++
//
//
//            default:
//                println("Unassigned Category : fail")
//                }
//                println("Inc Counter is \(counter)")
//
//            } else {
//                counter++
//                println("Error Counter is \(counter)")
//                println("Cannot select more than 5 categories")
//                let alert = UIAlertController(title: "Oops!", message: "Cannot select more than 5 categories.", preferredStyle: UIAlertControllerStyle.Alert)
//                let alertAction = UIAlertAction(title: "OK!", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in }
//                alert.addAction(alertAction)
//                presentViewController(alert, animated: true) { () -> Void in }
//            }
//    }
