//
//  IngredientSelectionViewController.swift
//  CraveFinal
//
//  Created by Sarthak Khillon on 8/26/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//


import UIKit
import RealmSwift

let cellIdentifier = "IngredientCell"
// by default, all rows will be selected. It is then up to the user to select or deselect as they feel is necessary.

class IngredientSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    
    /*
    bar button item
    didSet {
        enable button, don't gray out
    }
    */
    
    var cellLocation = 0
    var selectedIngredients: [[String]] = []
    var userIngredients: [String] = []
    var selectedTags: [String] = []
    
    //passed from CategoryCollectionVC
    var selectedCategories: [String]!
    
    // MARK: System functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userIngredients.isEmpty {
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
//        }
        
        for category in selectedCategories {
                 //   let category = self.categoryBank[indexPath.row]
        
        switch(category) {
            case "Afghan":
                let arr: [String] = ["onions", "lamb", "rice", "lentils", "bolani", "mantwo", "aushak", "kabob"]
                selectedIngredients.append(arr)
                selectedTags.append("4bf58dd8d48988d10f941735")

        
                    case "African":
                        let arr: [String] = ["corn", "fennel", "miele", "carrot", "scallion", "chicken", "ginger", "garlic", "olive oil", "cumin", "turmeric"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d1c8941735")
        
        
        
                    case "American":
                        let arr: [String] = ["cheese", "chicken", "beef", "onion", "salt", "pepper", "soup", "pasta", "oil", "garlic", "tomato", "sauce", "butter", "milk", "potatoes", "corn"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d14e941735")
        
        
                    case "Asian":
                        let arr: [String] = ["soy", "sauce", "rice", "vinegar", "fish", "sriracha", "oyster", "coconut", "curry", "miso", "paste", "sesame", "oil", "sake", "rice", "noodles", "ginger", "lime", "cilantro"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d142941735")
        
        
                    case "Caribbean":
                        let arr: [String] = ["allspice", "callaloo", "coconut", "molasses", "pigeon", "peas", "pepper", "plantains", "rum", "scotch", "chiles", "turmeric"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d144941735")
        
        
                    case "Chinese":
                        let arr: [String] = ["bamboo shoots", "bean", "chile", "noodles", "sticky", "rice", "jasmine", "shiitake", "sichuan", "soy", "sesame ", "water", "chestnuts"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d146941735")

                    case "Deli":
                        let arr: [String] = ["cold", "cuts", "salad", "pasta", "potato", "chicken", "tuna", "shrimp", "cheese", "eggplant", "pastrami", "roast beef", "salami", "ham", "turkey", "bologna"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d146941735")
        
                    case "Eastern European":
                        let arr: [String] = ["curd", "cheese", "kohlrabi", "peperivka", "kovbasa", "sorrel", "squash", "vegeta"]
                        selectedIngredients.append(arr)
                        selectedTags.append("52e81612bcbc57f1066b7a01")
        
                    case "French":
                        let arr: [String] = ["baguette", "butter", "cheese", "fleur", "herbes", "provence", "leeks", "mustard", "olive oil", "shallots", "tarragon", "chicken", "vinegar", "wine"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d10c941735")
        
                    case "German":
                        let arr: [String] = ["pork", "beef", "chicken", "duck", "goose", "prunes", "apples", "venison", "boar", "hare", "pheasant", "trout", "potato", "dumplings", "cabbage", "carrots", "radishes", "turnips", "asparagus"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d10d941735")
        
                    case "Hawaiian":
                        let arr: [String] = ["taro", "sweet potato", "purple yam", "breadfruit", "sea", "mineral", "ti", "hala", "limpets", "kukui", "imu", "beef", "pork", "chicken", "butterfish", "soy sauce", "sesame oil", "coconut milk", "squid", "cornstarch"]
                        selectedIngredients.append(arr)
                        selectedTags.append("52e81612bcbc57f1066b79fe")
        
                    case "Indian":
                        let arr: [String] = ["lentils", "chickpeas", "cardamom", "chili", "cinnamon", "coriander", "cumin", "masala", "ginger", "mustard seed", "onion", "garlic", "turmeric", "rice", "cheese", "chicken", "beans"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d10f941735")
        
                    case "Indonesian":
                        let arr: [String] = ["rice", "coconut", "turmeric", "wheat", "noodles", "bakpao", "cakwe", "yam", "sweet", "potato", "taro", "cassava", "maize", "breadfruit", "jackfruit", "spinach", "papaya", "cassava", "cabbage", "potato", "carrot", "beef", "chicken", "duck", "goat", "lamb"]
                        selectedIngredients.append(arr)
                        selectedTags.append("52960eda3cf9994f4e043ac9")
        
                    case "Italian":
                        let arr: [String] = ["tomatoes", "pasta", "rice", "flour", "beans", "bread", "artichoke", "olives", "olive oil", "garlic", "prosciutto", "basil", "mozzarella", "balsamic", "wine", "marsala", "parmesan"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d110941735")
        
                    case "Mediterranean":
                        let arr: [String] = ["olive oil", "lamb", "onions", "pepper", "tomato", "phyllo", "spinach", "feta", "cheese", "hummus", "chickpeas", "garlic", "eggplant", "cinnamon", "grape", "rice", "chicken", "beef", "tahini"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d1c0941735")
        
                    case "Mexican":
                        let arr: [String] = ["avocadoes", "beans", "cheese", "chipotle", "chocolate", "sour", "cream", "lime", "oregano", "poblanos", "tomatoes", "tortilla", "salsa"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d1c1941735")
        
                    case "Persian":
                        let arr: [String] = ["garbanzo beans", "onion", "garlic cloves", "garlic", "parsley", "flour", "salt", "cumin", "coriander", "cardamom", "fava beans", "chickpeas", "pita bread"]
                        selectedIngredients.append(arr)
                        selectedTags.append("52e81612bcbc57f1066b79f7")
        
                    case "Pizza":
                        let arr: [String] = ["wheat", "flour", "dough", "tomato", "garlic", "onion", "basil", "pepperoni", "bacon", "beef", "chicken", "italian", "sausage", "breast", "salami", "ham", "cheese", "ranch", "marinara"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d1ca941735")
        
                    case "Seafood":
                        let arr: [String] = ["shrimp", "tuna", "shellfish", "shark", "salmon", "sushi", "squid", "fish", "fillet", "cod", "mackerel", "anchovies"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d1d2941735")
            
                    case "Thai":
                        let arr: [String] = ["fish", "sauce", "nam", "pla", "anchovies", "cilantro", "basil", "coriander", "chile", "coconut", "milk", "palm", "lemongrass", "bamboo", "beancurd", "beansprouts"]
                        selectedIngredients.append(arr)
                        selectedTags.append("4bf58dd8d48988d149941735")
        
                    default:
                        println("Unassigned Category : fail")
                    }
                }
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return selectedCategories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var endResult = 0
        if (section == 0) {
            endResult = selectedIngredients[0].count
        }
        else if (section == 1) {
            endResult = selectedIngredients[1].count
        }
        else if (section == 2) {
            endResult = selectedIngredients[2].count
        }
        else if section == 3 {
            endResult = selectedIngredients[3].count
        }
        else if section == 4 {
            endResult = selectedIngredients[4].count
        }
        return endResult
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! IngredientSelectionViewCell
        
        
        // Configure the cell...
        if indexPath.section == 0 {
            cell.ingredientLabel.text = selectedIngredients[0][indexPath.row]
        } else if indexPath.section == 1 {
            cell.ingredientLabel.text = selectedIngredients[1][indexPath.row]
        } else if indexPath.section == 2 {
            cell.ingredientLabel.text = selectedIngredients[2][indexPath.row]
        } else if indexPath.section == 3 {
            cell.ingredientLabel.text = selectedIngredients[3][indexPath.row]
        } else if indexPath.section == 4 {
            cell.ingredientLabel.text = selectedIngredients[4][indexPath.row]
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName = ""
        
        if section == 0 {
            sectionName = selectedCategories[0]
        } else if section == 1 {
            sectionName = selectedCategories[1]
        } else if section == 2 {
            sectionName = selectedCategories[2]
        } else if section == 3 {
            sectionName = selectedCategories[3]
        } else if section == 4 {
            sectionName = selectedCategories[4]
        }
        
        return sectionName
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! IngredientSelectionViewCell
        self.userIngredients.append(cell.ingredientLabel.text!)
        println(userIngredients)
        
        if userIngredients.isEmpty {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! IngredientSelectionViewCell
        var found: Int?  // <= will hold the index if it was found, or else will be nil
        for i in (0...(userIngredients.count - 1)) {
            if userIngredients[i] == "\(cell.ingredientLabel.text!)" {
                found = i
            }
        }
        self.userIngredients.removeAtIndex(found!)
        println(userIngredients)
        
        if userIngredients.isEmpty {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlateSegue" {
            let destinationVC = segue.destinationViewController as! PlateViewController
            destinationVC.foodCategories = self.selectedTags
            destinationVC.ingredientData = self.userIngredients
        }
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