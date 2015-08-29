//
//  IngredientSelectionViewController.swift
//  CraveFinal
//
//  Created by Pankaj Khillon on 8/26/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//


import UIKit
import RealmSwift

let cellIdentifier = "IngredientCell"
// by default, all rows will be selected. It is then up to the user to select or deselect as they feel is necessary.

class IngredientSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cellLocation = 0
    
    var categoriesToEdit: [String] = []
    
    var categoryInformationDictionary: [String: [String]] = [:]
   
    var relevantIngredients: [Ingredient]!
    var ingredients: Ingredient!
    var relevantIngredientsLiked: RealmIngredientLiked!

    var food0: [String]!
    var food1: [String]!
    var food2: [String]!
    var food3: [String]!
    var food4: [String]!
    
    // MARK: Category Ingredient Arrays
    var afghanIngredients = ["onions", "lamb", "rice", "lentils", "bolani", "mantwo", "aushak", "kabob"]
    var africanIngredients = ["corn", "fennel", "miele", "carrot", "scallion", "chicken", "ginger", "garlic", "olive oil", "cumin", "turmeric"]
    var americanIngredients = ["cheese", "chicken", "beef", "onion", "salt", "pepper", "soup", "pasta", "oil", "garlic", "tomato", "sauce", "butter", "milk", "potatoes", "corn"]
    var asianIngredients = ["soy", "sauce", "rice", "vinegar", "fish", "sriracha", "oyster", "coconut", "curry", "miso", "paste", "sesame", "oil", "sake", "rice", "noodles", "ginger", "lime", "cilantro"]
    var caribbeanIngredients = ["allspice", "callaloo", "coconut", "molasses", "pigeon", "peas", "pepper", "plantains", "rum", "scotch", "chiles", "turmeric"]
    var chineseIngredients = ["bamboo shoots", "bean", "chile", "noodles", "sticky", "rice", "jasmine", "shiitake", "sichuan", "soy", "sesame ", "water", "chestnuts"]
    var deliIngredients = ["cold", "cuts", "salad", "pasta", "potato", "chicken", "tuna", "shrimp", "cheese", "eggplant", "pastrami", "roast beef", "salami", "ham", "turkey", "bologna"]
    var easternEuropeanIngredients = ["curd", "cheese", "kohlrabi", "peperivka", "kovbasa", "sorrel", "squash", "vegeta"]
    var frenchIngredients = ["baguette", "butter", "cheese", "fleur", "herbes", "provence", "leeks", "mustard", "olive oil", "shallots", "tarragon", "chicken", "vinegar", "wine"]
    var germanIngredients = ["pork", "beef", "chicken", "duck", "goose", "prunes", "apples", "venison", "boar", "hare", "pheasant", "trout", "potato", "dumplings", "cabbage", "carrots", "radishes", "turnips", "asparagus"]
    var hawaiianIngredients = ["taro", "sweet potato", "purple yam", "breadfruit", "sea", "mineral", "ti", "hala", "limpets", "kukui", "imu", "beef", "pork", "chicken", "butterfish", "soy sauce", "sesame oil", "coconut milk", "squid", "cornstarch"]
    var indianIngredients = ["lentils", "chickpeas", "cardamom", "chili", "cinnamon", "coriander", "cumin", "masala", "ginger", "mustard seed", "onion", "garlic", "turmeric", "rice", "cheese", "chicken", "beans"]
    var indonesianIngredients = ["rice", "coconut", "turmeric", "wheat", "noodles", "bakpao", "cakwe", "yam", "sweet", "potato", "taro", "cassava", "maize", "breadfruit", "jackfruit", "spinach", "papaya", "cassava", "cabbage", "potato", "carrot", "beef", "chicken", "duck", "goat", "lamb"]
    var italianIngredients = ["tomatoes", "pasta", "rice", "flour", "beans", "bread", "artichoke", "olives", "olive oil", "garlic", "prosciutto", "basil", "mozzarella", "balsamic", "wine", "marsala", "parmesan"]
    var mediterraneanIngredients = ["olive oil", "lamb", "onions", "pepper", "tomato", "phyllo", "spinach", "feta", "cheese", "hummus", "chickpeas", "garlic", "eggplant", "cinnamon", "grape", "rice", "chicken", "beef", "tahini"]
    var mexicanIngredients = ["avocadoes", "beans", "cheese", "chipotle", "chocolate", "sour", "cream", "lime", "oregano", "poblanos", "tomatoes", "tortilla", "salsa"]
    var persianIngredients = ["garbanzo beans", "onion", "garlic cloves", "garlic", "parsley", "flour", "salt", "cumin", "coriander", "cardamom", "fava beans", "chickpeas", "pita bread"]
    var pizzaIngredients = ["wheat", "flour", "dough", "tomato", "garlic", "onion", "basil", "pepperoni", "bacon", "beef", "chicken", "italian", "sausage", "breast", "salami", "ham", "cheese", "ranch", "marinara"]
    var seafoodIngredients = ["shrimp", "tuna", "shellfish", "shark", "salmon", "sushi", "squid", "fish", "fillet", "cod", "mackerel", "anchovies"]
    var thaiIngredients = ["fish", "sauce", "nam", "pla", "anchovies", "cilantro", "basil", "coriander", "chile", "coconut", "milk", "palm", "lemongrass", "bamboo", "beancurd", "beansprouts"]

    
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
        tableView.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //println("rows in section is " + "\(section)")
        var endResult = 0
        if (section == 0) {
            //newArray = food0
            endResult = food0.count
        }
        else if (section == 1) {
            //newArray = food0 + food1
            endResult = food1.count
        }
        else if (section == 2) {
            //newArray = food0 + food1 + food2
            endResult = food2.count
        }
        else if section == 3 {
            //newArray = food0 + food1 + food2 + food3
            endResult = food3.count
        }
        else if section == 4 {
            //newArray = food0 + food1 + food2 + food3 + food4
            endResult = food4.count
        }
        //println(newArray)
        return endResult
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        
        // Configure the cell...
        if indexPath.section == 0 {
            cell.nameIng.text = food0[indexPath.row]
            
        } else if indexPath.section == 1 {
            cell.nameIng.text = food1[indexPath.row]
        } else if indexPath.section == 2 {
            cell.nameIng.text = food2[indexPath.row]
        } else if indexPath.section == 3 {
            cell.nameIng.text = food3[indexPath.row]
        } else if indexPath.section == 4 {
            cell.nameIng.text = food4[indexPath.row]
        }
        return cell
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName: String = ""
        if (section == 0) {
            //newArray = food0
            sectionName = "food0"
        }
        else if (section == 1) {
            //newArray = food0 + food1
            sectionName = "food1"
        }
        else if (section == 2) {
            //newArray = food0 + food1 + food2
            sectionName = "food2"
        }
        else if section == 3 {
            //newArray = food0 + food1 + food2 + food3
            sectionName = "food3"
        }
        else if section == 4 {
            //newArray = food0 + food1 + food2 + food3 + food4
            sectionName = "food4"
        }
        return sectionName
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! MealTableViewCell
        //cell!.alpha = 1.0
        //var selectedText = cell?.textLabel?.text
        self.selectedIngredients.append(cell.nameIng.text!)
        //println(cell.nameIng.text!)
        println(selectedIngredients)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! MealTableViewCell
        //let indexToRemove = selectedIngredients.find("\(cell.nameIng.text!)")
        
        var found: Int?  // <= will hold the index if it was found, or else will be nil
        for i in (0...(selectedIngredients.count - 1)) {
            if selectedIngredients[i] == "\(cell.nameIng.text!)" {
                found = i
            }
        }
        self.selectedIngredients.removeAtIndex(found!)
        println(selectedIngredients)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

extension Array {
    func find (includedElement: T -> Bool) -> Int? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}