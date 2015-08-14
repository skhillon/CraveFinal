//            Alamofire.request(.GET, requestString).responseString() {
//                (_, _, responseBody, _) in
//                //                if let url = NSURL(string: urlString) { // if #1
//                //                    if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil) { //if #2
//                if let data = responseBody!.dataUsingEncoding(NSUTF8StringEncoding) {
//                    let json = JSON(data: data)
//                    //println(json)
//                    //println(json.description)
//                    if json["meta"]["code"].intValue == 200 { //if #3
//                        let menuContainer = json["response"]["menu"]["menus"].dictionary
//                        let menuCount = menuContainer!["count"]!.int!
//                        println(menuContainer)
//                        //if menuCount == 1 { //if #4
//                        
//                        let menuItems = menuContainer!["items"]?.arrayValue
//                        if let menuElements = menuItems {
//                            for item in menuElements {
//                                let menuSections = item["entries"].dictionaryValue //subheadings in menus
//                                let subheadings = menuSections["items"]!.arrayValue
//                                //println(subheadings.count)
//                                for sub in subheadings {
//                                    let entries = sub["entries"].dictionaryValue
//                                    let food = entries["items"]!.arrayValue
//                                    //println(food.count)
//                                    for foodStuff in food {
//                                        // println(self.foundMeals.count)
//                                        for meal in self.foundMeals {
//                                            let mealTitle = foodStuff["name"].stringValue
//                                            let mealDescription = foodStuff["description"].stringValue
//                                            let priceValue = foodStuff["price"].stringValue
//                                            
//                                            meal.mealTitle = mealTitle
//                                            meal.mealDescription = mealDescription
//                                            meal.priceValue = priceValue
//                                            
//                                            
//                                            print(meal.mealTitle)
//                                            //println(meal.priceValue)
//                                            //                                                println(meal.mealDescription)
//                                            //                                                println(meal.addressofVenue)
//                                            //
//                                            //                                                // ===== ACCESSED ========
//                                            //                                                println(meal.distanceToVenue)
//                                            //                                                println(meal.longitudeOfVenue)
//                                            //                                                println(meal.latitudeOfVenue)
//                                            // println(meal.nameOfVenue)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        //}// end if #4
//                    } else {
//                        println("Error in retrieving JSON")
//                    }
//                }
//                //                    }
//                //                }
//                
//                
//                
//            }